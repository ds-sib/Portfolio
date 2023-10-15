SELECT
    Month,
    Revenue
FROM
    (
    SELECT
        toStartOfMonth(InvoiceDate) AS Month,
        toInt32(SUM(Quantity * UnitPrice)) AS Revenue
    FROM 
        default.retail
    WHERE
        Month !='2011-12-01'
    GROUP BY
        Month
    ORDER BY
        Month DESC
    LIMIT 12
    )
ORDER BY
    Month ASC
