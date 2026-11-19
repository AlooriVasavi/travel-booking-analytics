USE travel_bookings_database;

-- 1. Row count & unique bookings check
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT booking_id) AS unique_bookings,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM clean_travel_data;

-- 2. Missing / blank check on key text & numeric columns
SELECT
    SUM(CASE WHEN destination IS NULL OR TRIM(destination) = '' THEN 1 ELSE 0 END) AS missing_destination,
    SUM(CASE WHEN booking_status IS NULL OR TRIM(booking_status) = '' THEN 1 ELSE 0 END) AS missing_status,
    SUM(CASE WHEN total_amount_inr IS NULL THEN 1 ELSE 0 END) AS missing_total_amount
FROM clean_travel_data;

-- 3. Core Financial KPIs (INR)
SELECT
    COUNT(*) AS total_bookings,
    ROUND(SUM(COALESCE(base_price_inr, 0)), 2) AS total_base_price_inr,
    ROUND(SUM(COALESCE(discount_amount_inr, 0)), 2) AS total_discount_inr,
    ROUND(SUM(COALESCE(total_amount_inr, 0)), 2) AS net_revenue_inr,
    ROUND(AVG(COALESCE(total_amount_inr, 0)), 2) AS avg_booking_value_inr,
    ROUND(AVG(COALESCE(discount_pct, 0)), 2) AS avg_discount_pct
FROM clean_travel_data;