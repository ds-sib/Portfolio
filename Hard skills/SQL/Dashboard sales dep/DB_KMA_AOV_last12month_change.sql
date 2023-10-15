 SELECT
    Month,
    AOV
FROM
    (
    SELECT
        Month,
        AOV
    FROM
        (
        SELECT
            Month,
            AOV,
            neighbor(AOV, -1, 0) AS previous_month_AOV,
            AOV - previous_month_AOV AS month_diff,
            ROUND((AOV - previous_month_AOV) / previous_month_AOV * 100, 1) AS percentage_month_diff
        FROM
            (
            SELECT
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
                Month
            )
        )
    WHERE
        Month != '2011-12-01'
    ORDER BY
        Month DESC
    LIMIT 12
    )
ORDER BY
    Month ASC