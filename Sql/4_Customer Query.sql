/* ==============================================================================
   DASHBOARD 4: CUSTOMER BEHAVIOR & DEMOGRAPHICS (CLEAN & READY)
   Database: hotel
   Table: hotel_bookings
============================================================================== */

USE hotel;
GO

-- ==============================================================================
-- TOPIC 1: GUEST DEMOGRAPHICS & PROFILE
-- ==============================================================================

-- Question 1: Demographic distribution of guests (Solo, Couples, Families, Groups)
SELECT 
    CASE 
        WHEN (adults + children + babies) = 1 THEN 'Solo Traveler'
        WHEN (adults = 2 AND children = 0 AND babies = 0) THEN 'Couples'
        WHEN (children > 0 OR babies > 0) THEN 'Families'
        ELSE 'Groups/Others'
    END AS guest_category,
    COUNT(*) AS total_bookings,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hotel_bookings WHERE is_canceled = 0) AS decimal (5,2)) as pct_of_total
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY 
    CASE 
        WHEN (adults + children + babies) = 1 THEN 'Solo Traveler'
        WHEN (adults = 2 AND children = 0 AND babies = 0) THEN 'Couples'
        WHEN (children > 0 OR babies > 0) THEN 'Families'
        ELSE 'Groups/Others'
    END
ORDER BY total_bookings DESC;


-- Question 2: Average length of stay (Families vs Solo/Couples)
SELECT 
    hotel,
    CASE 
        WHEN (children > 0 OR babies > 0) THEN 'Family' 
        ELSE 'Single/Couples' 
    END AS guest_type,
    ROUND(AVG(CAST((stays_in_week_nights + stays_in_weekend_nights) AS FLOAT)), 2) AS avg_stay_duration,
    COUNT(*) AS total_reservations
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY 
    hotel,
    CASE 
        WHEN (children > 0 OR babies > 0) THEN 'Family' 
        ELSE 'Single/Couples' 
    END
ORDER BY hotel, avg_stay_duration DESC;


-- Question 3: Top 10 origin countries broken down by family vs individual
SELECT TOP 10 
    country,
    COUNT(*) AS total_confirmed_bookings,
    SUM(CASE WHEN (children > 0 OR babies > 0) THEN 1 ELSE 0 END) AS family_bookings,
    SUM(CASE WHEN (children = 0 AND babies = 0) THEN 1 ELSE 0 END) AS individual_bookings
FROM hotel_bookings
WHERE is_canceled = 0 AND country IS NOT NULL
GROUP BY country
ORDER BY total_confirmed_bookings DESC;


-- ==============================================================================
-- TOPIC 2: GUEST PREFERENCES & AMENITIES
-- ==============================================================================

-- Question 4: Most popular meal plans across each hotel
SELECT 
    hotel, 
    meal, 
    COUNT(*) AS total_orders,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY hotel) AS decimal(5,2)) AS preference_pct
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY hotel, meal
ORDER BY hotel, total_orders DESC;


-- Question 5: Most reserved room types by customer type
SELECT 
    reserved_room_type,
    customer_type,
    COUNT(*) AS total_demand
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY reserved_room_type, customer_type
ORDER BY reserved_room_type, total_demand DESC;


-- Question 6: Total demand for parking spaces
SELECT 
    hotel,
    CASE 
        WHEN (children > 0 OR babies > 0) THEN 'Family' 
        ELSE 'Individual/Couples' 
    END AS guest_category,
    SUM(required_car_parking_spaces) AS total_parking_spaces_requested,
    COUNT(*) AS total_bookings_requiring_parking
FROM hotel_bookings
WHERE is_canceled = 0 AND required_car_parking_spaces > 0
GROUP BY 
    hotel,
    CASE 
        WHEN (children > 0 OR babies > 0) THEN 'Family' 
        ELSE 'Individual/Couples' 
    END
ORDER BY hotel, total_parking_spaces_requested DESC;


-- ==============================================================================
-- TOPIC 3: SERVICE INTENSITY & OPERATIONS
-- ==============================================================================

-- Question 7: Special requests by customer type
SELECT 
    customer_type,
    COUNT(*) AS total_bookings,
    SUM(total_of_special_requests) AS total_requests,
    ROUND(AVG(CAST(total_of_special_requests AS FLOAT)), 2) AS avg_special_requests_per_guest
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY customer_type
ORDER BY avg_special_requests_per_guest DESC;


-- Question 8: Booking changes made by families vs single/couples
SELECT 
    CASE 
        WHEN (children > 0 OR babies > 0) THEN 'Family' 
        ELSE 'Solo/Couples' 
    END AS guest_type,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN booking_changes > 0 THEN 1 ELSE 0 END) AS bookings_with_changes,
    CAST(AVG(CASE WHEN booking_changes > 0 THEN 1.0 ELSE 0.0 END) * 100 AS DECIMAL(5, 2)) AS change_rate_pct,
    ROUND(AVG(CAST(booking_changes AS FLOAT)), 2) AS avg_changes_count
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY 
    CASE 
        WHEN (children > 0 OR babies > 0) THEN 'Family' 
        ELSE 'Solo/Couples' 
    END


-- Question 9: Room discrepancy rate (reserved vs assigned) per hotel
SELECT 
    hotel,
    COUNT(*) AS total_checked_in,
    SUM(CASE WHEN reserved_room_type <> assigned_room_type THEN 1 ELSE 0 END) AS room_changed_count,
    cast(AVG(CASE WHEN reserved_room_type <> assigned_room_type THEN 1.0 ELSE 0.0 END) * 100 as decimal(5,2)) room_discrepancy_rate_pct
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY hotel;


-- ==============================================================================
-- TOPIC 4: GUEST LOYALTY & RETENTION
-- ==============================================================================

-- Question 10: Channels distribution for repeated guests
SELECT 
    distribution_channel,
    market_segment,
    COUNT(*) AS total_repeated_bookings,
    cast(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hotel_bookings WHERE is_repeated_guest = 1) AS decimal (5,2)) AS pct_of_all_repeaters
FROM hotel_bookings
WHERE is_repeated_guest = 1
GROUP BY distribution_channel, market_segment
ORDER BY total_repeated_bookings DESC;