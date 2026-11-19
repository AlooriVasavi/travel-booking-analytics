USE travel_bookings_database;

WITH channel_metrics AS (
    SELECT
        COALESCE(NULLIF(TRIM(booking_channel), ''), 'Unknown') AS booking_channel,
        COUNT(*) AS total_bookings,
        SUM(COALESCE(discount_amount_inr, 0)) AS total_discount_inr,
        SUM(COALESCE(total_amount_inr, 0)) AS channel_revenue_inr
    FROM clean_travel_data
    GROUP BY COALESCE(NULLIF(TRIM(booking_channel), ''), 'Unknown')
),
grand_total AS (
    SELECT SUM(channel_revenue_inr) AS overall_revenue_inr
    FROM channel_metrics
)
SELECT
    cm.booking_channel,
    cm.total_bookings,
    ROUND(cm.total_discount_inr, 2) AS total_discount_inr,
    ROUND(cm.channel_revenue_inr, 2) AS channel_revenue_inr,
    ROUND((cm.channel_revenue_inr / NULLIF(gt.overall_revenue_inr, 0)) * 100, 2) AS revenue_share_pct
FROM channel_metrics cm
CROSS JOIN grand_total gt
ORDER BY cm.channel_revenue_inr DESC;

-- Booking Status & Payment Method breakdown
SELECT
    COALESCE(NULLIF(TRIM(booking_status), ''), 'Unknown') AS booking_status,
    COALESCE(NULLIF(TRIM(payment_method), ''), 'Unknown') AS payment_method,
    COUNT(*) AS bookings_count,
    ROUND(SUM(COALESCE(total_amount_inr, 0)), 2) AS revenue_inr
FROM clean_travel_data
GROUP BY
    COALESCE(NULLIF(TRIM(booking_status), ''), 'Unknown'),
    COALESCE(NULLIF(TRIM(payment_method), ''), 'Unknown')
ORDER BY revenue_inr DESC;