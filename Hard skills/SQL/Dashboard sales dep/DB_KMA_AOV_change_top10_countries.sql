SELECT
    one.Country,
    two.AOV,
    two.percentage_month_diff
    
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
        AOV,
        percentage_month_diff
    FROM
        (
        SELECT
            Country,
            Month,
            AOV,
            neighbor(AOV, -1, 0) AS previous_month_AOV,
            AOV - previous_month_AOV AS month_diff,
            ROUND((AOV - previous_month_AOV) / previous_month_AOV * 100, 1) AS percentage_month_diff
        FROM
            (
            SELECT
                Country,
                Month,
                AVG(Revenue) AS AOV
            FROM
                (
                SELECT
                   InvoiceNo,
                   Country,
                   toStartOfMonth(InvoiceDate) AS Month,
                   SUM(Quantity * UnitPrice) AS Revenue
                FROM retail
                GROUP BY
                   InvoiceNo,
                   Country,
                   Month
                HAVING
                   Revenue > 0
                )
            GROUP BY
                Country,
                Month
            ORDER BY
                Country ASC,
                Month ASC
            )
        )
    WHERE 
        Month = '2011-11-01'
    ) AS two
ON one.Country = two.Country