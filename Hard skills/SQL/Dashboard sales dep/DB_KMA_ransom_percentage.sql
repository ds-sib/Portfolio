SELECT
    Month,
    l.Revenue / (l.Revenue + r.Canceled) * 100 AS Ransom_percentage
FROM
    (
    SELECT
        toStartOfMonth(InvoiceDate) AS Month,
        SUM(Quantity * UnitPrice) AS Revenue
    FROM
        retail
    GROUP BY
        Month
    LIMIT 100
    ) AS l
JOIN
    (
    SELECT
        toStartOfMonth(InvoiceDate) AS Month,
        SUM(Quantity * UnitPrice) * -1 AS Canceled
    FROM
        retail
    WHERE
        Quantity < 0
    GROUP BY
        Month
    LIMIT 100
    ) AS r
ON l.Month = r.Month
WHERE
    Month = '2011-11-01'
    