SELECT
    one.Country,
    two.dec_revenue,
    two.month_diff
    
FROM
    -- Finding Top 10 countries before last month (november) 
    (
    SELECT
        Country,
        uniqExact(toStartOfMonth(InvoiceDate)) AS Month,
        toInt32(SUM(Quantity * UnitPrice)) AS Revenue
    FROM 
        default.retail
    WHERE
            toStartOfMonth(InvoiceDate) != '2011-11-01' --We imagine, that we've data only up to December and should kick it from counting
    GROUP BY
        Country
    ORDER BY
        Revenue DESC
    LIMIT 10
    ) AS one
    
JOIN
    -- Creating table with revenue changes in December compared to November
    (
    SELECT
        Country,
        Month,
        dec_revenue,
        nov_revenue,
        month_diff
    FROM
        (
        SELECT
            Country,
            Month,
            Revenue AS dec_revenue,
            neighbor(Revenue, -1, Revenue) AS nov_revenue, --Adding revenue for the previous month
            ROUND((Revenue - nov_revenue) / nov_revenue * 100, 1) AS month_diff --Counting difference with previous month
        FROM
            -- Counting revenue in November and december for each code
            (
            SELECT
            Country,
            Month,
            Revenue
            FROM
                (
                SELECT
                    Country,
                    toStartOfMonth(InvoiceDate) AS Month,
                    toInt32(SUM(Quantity * UnitPrice)) AS Revenue
                FROM 
                    default.retail
                WHERE
                        toStartOfMonth(InvoiceDate) = '2011-11-01'
                    OR
                        toStartOfMonth(InvoiceDate) = '2011-10-01'
                GROUP BY
                    Country,
                    Month
                ORDER BY
                    Country ASC,
                    Month ASC
                ) 
            ) AS l
        JOIN
            -- Filter, that help us to show codes with revenue in both monthes (If we use PostgreSQL, we can solve this with window func)
            (
            SELECT
                Country,
                COUNT(Country) AS count
            FROM
                (
                SELECT
                    Country,
                    toStartOfMonth(InvoiceDate) AS Month,
                    toInt32(SUM(Quantity * UnitPrice)) AS Revenue
                FROM 
                    default.retail
                WHERE
                        toStartOfMonth(InvoiceDate) = '2011-11-01'
                    OR
                        toStartOfMonth(InvoiceDate) = '2011-10-01'
                GROUP BY
                    Country,
                    Month
                ) 
            GROUP BY
                Country
            HAVING
                count = 2
            ) AS r
        ON l.Country = r.Country
        )
    WHERE
        Month = '2011-11-01' --Kicking October
    ) AS two
ON one.Country = two.Country