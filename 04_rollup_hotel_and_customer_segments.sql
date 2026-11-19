USE travel_bookings_database;

-- Hotel Category aur Trip Type ke subtotals + grand total (ROLLUP)
SELECT
    COALESCE(NULLIF(TRIM(hotel_category), ''), 'All Hotels') AS hotel_category,
    COALESCE(NULLIF(TRIM(trip_type), ''), 'All Trip Types') AS trip_type,
    COUNT(*) AS total_bookings,
    ROUND(SUM(COALESCE(total_amount_inr, 0)), 2) AS total_revenue_inr
FROM clean_travel_data
GROUP BY
    COALESCE(NULLIF(TRIM(hotel_category), ''), 'All Hotels'),
    COALESCE(NULLIF(TRIM(trip_type), ''), 'All Trip Types') WITH ROLLUP;

-- Age Group & Gender analysis
SELECT
    CASE
        WHEN customer_age < 25 THEN 'Under 25'
        WHEN customer_age BETWEEN 25 AND 34 THEN '25-34'
        WHEN customer_age BETWEEN 35 AND 44 THEN '35-44'
        WHEN customer_age BETWEEN 45 AND 59 THEN '45-59'
        WHEN customer_age >= 60 THEN '60+'
        ELSE 'Unknown'
    END AS age_group,
    COALESCE(NULLIF(TRIM(gender), ''), 'Unspecified') AS gender,
    COUNT(*) AS bookings_count,
    ROUND(AVG(COALESCE(total_amount_inr, 0)), 2) AS avg_spend_inr,
    ROUND(SUM(COALESCE(total_amount_inr, 0)), 2) AS total_spend_inr
FROM clean_travel_data
GROUP BY
    CASE
        WHEN customer_age < 25 THEN 'Under 25'
        WHEN customer_age BETWEEN 25 AND 34 THEN '25-34'
        WHEN customer_age BETWEEN 35 AND 44 THEN '35-44'
        WHEN customer_age BETWEEN 45 AND 59 THEN '45-59'
        WHEN customer_age >= 60 THEN '60+'
        ELSE 'Unknown'
    END,
    COALESCE(NULLIF(TRIM(gender), ''), 'Unspecified')
ORDER BY total_spend_inr DESC;