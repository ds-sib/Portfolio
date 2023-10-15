SELECT
    one.StockCode,
    one.Description,
    two.dec_revenue,
    two.month_diff

FROM
    -- Finding Top 10 bestsellers before last month (december) 
    (
    SELECT
        StockCode,
        Description,
        uniqExact(toStartOfMonth(InvoiceDate)) AS Month,
        toInt32(SUM(Quantity * UnitPrice)) AS Revenue
    FROM 
        default.retail
    WHERE
            toStartOfMonth(InvoiceDate) != '2011-11-01' --We imagine, that we've data only up to December and should kick it from counting
    GROUP BY
        StockCode,
        Description
    HAVING
        Month > 8 --Filter for items, which has relevant data during year (8 monthes or more)
    ORDER BY
        Revenue DESC
    LIMIT 10 
    ) AS one
    
JOIN
    -- Creating table with revenue changes in December compared to November
    (
    SELECT
        StockCode,
        Month,
        dec_revenue,
        nov_revenue,
        month_diff
    FROM
        (
        SELECT
            StockCode,
            Month,
            Revenue AS dec_revenue,
            neighbor(Revenue, -1, Revenue) AS nov_revenue, --Adding revenue for the previous month
            ROUND((Revenue - nov_revenue) / nov_revenue * 100, 1) AS month_diff --Counting difference with previous month
        FROM
            -- Counting revenue in November and december for each code
            (
            SELECT
            StockCode,
            Month,
            Revenue
            FROM
                (
                SELECT
                    StockCode,
                    toStartOfMonth(InvoiceDate) AS Month,
                    toInt32(SUM(Quantity * UnitPrice)) AS Revenue
                FROM 
                    default.retail
                WHERE
                        toStartOfMonth(InvoiceDate) = '2011-11-01'
                    OR
                        toStartOfMonth(InvoiceDate) = '2011-10-01'
                GROUP BY
                    StockCode,
                    Month
                ORDER BY
                    StockCode ASC,
                    Month ASC
                ) 
            ) AS l
        JOIN
            -- Filter, that help us to show codes with revenue in both monthes (If we use PostgreSQL, we can solve this with window func)
            (
            SELECT
                StockCode,
                COUNT(StockCode) AS count
            FROM
                (
                SELECT
                    StockCode,
                    toStartOfMonth(InvoiceDate) AS Month,
                    toInt32(SUM(Quantity * UnitPrice)) AS Revenue
                FROM 
                    default.retail
                WHERE
                        toStartOfMonth(InvoiceDate) = '2011-11-01'
                    OR
                        toStartOfMonth(InvoiceDate) = '2011-10-01'
                GROUP BY
                    StockCode,
                    Month
                ) 
            GROUP BY
                StockCode
            HAVING
                count = 2
            ) AS r
        ON l.StockCode = r.StockCode
        )
    WHERE
        Month = '2011-11-01' --Kicking November
    ) AS two
ON one.StockCode = two.StockCode