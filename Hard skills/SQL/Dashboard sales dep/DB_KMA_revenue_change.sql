SELECT
    Revenue,
    month_diff,
    previous_month_revenue,
    percentage_month_diff
FROM
    (
    SELECT
        toStartOfMonth(InvoiceDate) AS Month,
        toInt32(SUM(Quantity * UnitPrice)) AS Revenue,
        neighbor(Revenue, -1, 0) AS previous_month_revenue,
        Revenue - previous_month_revenue AS month_diff,
        ROUND((Revenue - previous_month_revenue) / previous_month_revenue * 100, 1) AS percentage_month_diff
    FROM 
        default.retail
    GROUP BY
        Month
    ORDER BY
        Month ASC
    )
WHERE Month = '2011-11-01'