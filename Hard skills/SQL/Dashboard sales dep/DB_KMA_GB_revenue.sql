SELECT
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
        Month !='2011-12-01'
    GROUP BY
        Country,
        Month
    ORDER BY
        Month DESC
    )
WHERE
    Country = 'United Kingdom'
ORDER BY
    Month ASC
