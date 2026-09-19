SELECT 
    hotel,
    CAST(SUM((stays_in_weekend_nights + stays_in_week_nights) * adr) AS INT) AS Total_Revenue
FROM 
    [hotel_bookings_cleaned.csv]
WHERE 
    is_canceled = 0 
GROUP BY 
    hotel
ORDER BY 
    Total_Revenue DESC;

SELECT 
    arrival_date_month,
    CAST(AVG(adr) AS DECIMAL(10,2)) AS Average_Daily_Rate
FROM 
    [hotel_bookings_cleaned.csv]
WHERE 
    is_canceled = 0
GROUP BY 
    arrival_date_month
ORDER BY 
	Average_Daily_Rate DESC; 

SELECT 
    arrival_date_month,
    CAST(SUM((stays_in_weekend_nights + stays_in_week_nights) * adr) AS INT) AS Lost_Revenue
FROM 
    [hotel_bookings_cleaned.csv]
WHERE 
    is_canceled = 1 
GROUP BY 
    arrival_date_month
ORDER BY 
    Lost_Revenue DESC;

SELECT 
    market_segment,
    CAST(AVG(adr) AS DECIMAL(10,2)) AS Average_ADR
FROM 
    [hotel_bookings_cleaned.csv]
WHERE 
    is_canceled = 0
GROUP BY 
    market_segment
ORDER BY 
    Average_ADR DESC;

SELECT 
    hotel,
    CAST(AVG(lead_time) AS INT) AS Average_Lead_Time_Days,
	CAST(SUM((stays_in_weekend_nights + stays_in_week_nights) * adr) AS INT) AS Total_Revenue
FROM 
    [hotel_bookings_cleaned.csv]
WHERE 
    is_canceled = 0
GROUP BY 
    hotel
ORDER BY 
    Total_Revenue DESC;

SELECT 
    meal,
    CAST(SUM((stays_in_weekend_nights + stays_in_week_nights) * adr) AS INT) AS Total_Revenue,
	COUNT(*) AS Number_Of_Bookings
FROM 
    [hotel_bookings_cleaned.csv]
WHERE 
    is_canceled = 0
GROUP BY 
    meal
ORDER BY 
    Total_Revenue DESC;

SELECT TOP 5
    country,
    CAST(SUM((stays_in_weekend_nights + stays_in_week_nights) * adr) AS INT) AS Total_Revenue
FROM 
    [hotel_bookings_cleaned.csv]
WHERE 
    is_canceled = 0 AND country IS NOT NULL
GROUP BY 
    country
ORDER BY 
    Total_Revenue DESC;



