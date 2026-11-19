# Travel Booking Analytics (MySQL)

## Project Overview
This project analyzes a **500-row, 21-column** travel bookings dataset (`clean_travel_data.csv`) in **MySQL** to evaluate data quality, core revenue KPIs, top destinations, trip and package performance, booking channels, discount patterns, and customer/hotel segments.

## Tools & Concepts
- **Database & Querying:** MySQL Server, MySQL Workbench
- **SQL Concepts:** Aggregations (`COUNT`, `SUM`, `AVG`, `ROUND`), Null/Blank Handling (`COALESCE`, `NULLIF`), Conditional Logic (`CASE WHEN`), Grouping & Sorting (`GROUP BY`, `ORDER BY`), Common Table Expressions (`CTE` / `WITH`), and `WITH ROLLUP`

## Dataset Overview (`clean_travel_data.csv`)
- **Rows:** 500
- **Columns (21):** `booking_id`, `booking_date`, `travel_date`, `customer_id`, `customer_age`, `gender`, `origin_city`, `destination`, `trip_type`, `package_type`, `booking_channel`, `hotel_category`, `nights`, `adults`, `children`, `booking_status`, `payment_method`, `base_price_inr`, `discount_pct`, `discount_amount_inr`, `total_amount_inr`

## SQL Scripts Included
- `01_data_audit_and_kpis.sql` — Row and unique ID checks, missing/blank value audits, and overall INR KPIs (`base_price_inr`, `discount_amount_inr`, `total_amount_inr`).
- `02_destination_and_package_analysis.sql` — Top 10 destinations by net revenue, traveler counts, nights, and breakdown across `trip_type` and `package_type`.
- `03_cte_channel_discount_and_status.sql` — CTE-based revenue and share (%) by `booking_channel`, along with `booking_status` and `payment_method` analysis.
- `04_rollup_hotel_and_customer_segments.sql` — Multi-level subtotals and grand totals using `WITH ROLLUP` across `hotel_category` and `trip_type`, plus age-group and gender spending analysis.

## How to Run
1. Import `clean_travel_data.csv` into a MySQL database table (for example, `clean_travel_data`).
2. Run the scripts in sequence from `01_data_audit_and_kpis.sql` to `04_rollup_hotel_and_customer_segments.sql` in MySQL Workbench.
