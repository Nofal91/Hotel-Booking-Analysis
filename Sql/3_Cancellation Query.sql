
                ---Operations & Cancellation Analysis---

--Q1--How does cancellation rate differ by lead time?               
SELECT
    CASE
        WHEN lead_time <= 7 THEN '0-7 Days'
        WHEN lead_time <= 30 THEN '8-30 Days'
        WHEN lead_time <= 90 THEN '31-90 Days'
        ELSE '90+ Days'
    END AS lead_time_group,

    COUNT(*) AS total_bookings,

    SUM(CAST(is_canceled AS INT)) AS canceled_bookings,

    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS cancellation_rate

FROM [hotel_bookings_cleaned.csv]

GROUP BY
    CASE
        WHEN lead_time <= 7 THEN '0-7 Days'
        WHEN lead_time <= 30 THEN '8-30 Days'
        WHEN lead_time <= 90 THEN '31-90 Days'
        ELSE '90+ Days'
    END

ORDER BY cancellation_rate DESC; 
----------------------------------------- 
--Q2--How does cancellation rate differ by deposit type?
SELECT
    deposit_type,
    COUNT(*) AS total_bookings,
   SUM(CAST(is_canceled AS INT)) AS canceled_bookings,
    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS cancellation_rate

FROM [hotel_bookings_cleaned.csv]

GROUP BY deposit_type

ORDER BY cancellation_rate DESC;
------------------------------------------
--Q3--How does cancellation rate differ
--between bookings with and without room type changes?
SELECT
    CASE
        WHEN room_type_changed = 1 THEN 'Room Type Changed'
        ELSE 'No Room Type Change'
    END AS room_change_status,

    COUNT(*) AS total_bookings,

    SUM(CAST(is_canceled AS INT)) AS canceled_bookings,

    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS cancellation_rate

FROM [hotel_bookings_cleaned.csv]

GROUP BY
    CASE
        WHEN room_type_changed = 1 THEN 'Room Type Changed'
        ELSE 'No Room Type Change'
    END

ORDER BY cancellation_rate DESC;
----------------------------------------------
--Q4--Which arrival months have the highest cancellation rates?
SELECT
    arrival_date_month,
    COUNT(*) AS total_bookings,
    SUM(CAST(is_canceled AS INT)) AS canceled_bookings,
    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS cancellation_rate

FROM [hotel_bookings_cleaned.csv]

GROUP BY arrival_date_month

ORDER BY cancellation_rate DESC;
------------------------------------------------
--Q5--How do Special Requests relate to Cancellation Rates?
SELECT 
    total_of_special_requests,
    COUNT(*) AS total_bookings,
    SUM(CAST(is_canceled AS INT)) AS canceled_bookings,
    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS cancellation_rate_percentage
FROM 
    [hotel_bookings_cleaned.csv]
GROUP BY 
    total_of_special_requests
ORDER BY 
    total_of_special_requests ASC;
----------------------------------------------------
--Q6--How does cancellation rate differ based on previous cancellation history?

SELECT
    CASE
        WHEN previous_cancellations > 0 THEN 'Previous Cancellations'
        ELSE 'No Previous Cancellations'
    END AS cancellation_history,

    COUNT(*) AS total_bookings,

    SUM(CAST(is_canceled AS INT)) AS canceled_bookings,

    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS cancellation_rate

FROM [hotel_bookings_cleaned.csv]

GROUP BY
    CASE
        WHEN previous_cancellations > 0 THEN 'Previous Cancellations'
        ELSE 'No Previous Cancellations'
    END
ORDER BY cancellation_rate DESC;
-------------------------------------------------------
--Q7--How does cancellation rate differ 
--between bookings with and without booking changes?

SELECT
    CASE
        WHEN booking_changes > 0 THEN 'With Booking Changes'
        ELSE 'No Booking Changes'
    END AS booking_change_status,

    COUNT(*) AS total_bookings,

    SUM(CAST(is_canceled AS INT)) AS canceled_bookings,
    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS cancellation_rate

FROM [hotel_bookings_cleaned.csv]

GROUP BY
    CASE
        WHEN booking_changes > 0 THEN 'With Booking Changes'
        ELSE 'No Booking Changes'
    END
ORDER BY cancellation_rate DESC;
----------------------------------------------------------
--Q8--Total Bookings
SELECT
    COUNT(*) AS total_bookings
FROM [hotel_bookings_cleaned.csv];
--------------------------
--Q9--Overall Cancellation Rate
SELECT
    ROUND(AVG(CAST(is_canceled AS FLOAT)) * 100, 2) AS overall_cancellation_rate
FROM [hotel_bookings_cleaned.csv];
----------------------------



