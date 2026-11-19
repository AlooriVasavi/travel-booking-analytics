USE travel_bookings_database;

-- Top 10 Destinations by Net Revenue
SELECT
    COALESCE(NULLIF(TRIM(destination), ''), 'Unknown') AS destination,
    COUNT(*) AS total_bookings,
    SUM(COALESCE(nights, 0)) AS total_nights,
    SUM(COALESCE(adults, 0) + COALESCE(children, 0)) AS total_travelers,
    ROUND(SUM(COALESCE(total_amount_inr, 0)), 2) AS total_revenue_inr
FROM clean_travel_data
GROUP BY COALESCE(NULLIF(TRIM(destination), ''), 'Unknown')
ORDER BY total_revenue_inr DESC
LIMIT 10;

-- Performance by Trip Type & Package Type
SELECT
    COALESCE(NULLIF(TRIM(trip_type), ''), 'Unspecified') AS trip_type,
    COALESCE(NULLIF(TRIM(package_type), ''), 'Unspecified') AS package_type,
    COUNT(*) AS total_bookings,
    ROUND(AVG(COALESCE(nights, 0)), 1) AS avg_nights,
    ROUND(SUM(COALESCE(total_amount_inr, 0)), 2) AS total_revenue_inr
FROM clean_travel_data
GROUP BY
    COALESCE(NULLIF(TRIM(trip_type), ''), 'Unspecified'),
    COALESCE(NULLIF(TRIM(package_type), ''), 'Unspecified')
ORDER BY total_revenue_inr DESC;