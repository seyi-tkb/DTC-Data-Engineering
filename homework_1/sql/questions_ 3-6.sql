-- Question 3. Counting short trips
-- For the trips in November 2025 (lpep_pickup_datetime between '2025-11-01' and '2025-12-01', exclusive of the upper bound), how many trips had a trip_distance of less than or equal to 1 mile?

SELECT 
	COUNT(lpep_pickup_datetime) pickup_count
FROM 
	green_taxi
WHERE
		lpep_pickup_datetime BETWEEN '2025-11-01' AND '2025-12-01'
	AND 
		trip_distance <= 1;

-- Ans. 8007 (B)


-- Question 4. Longest trip for each day
-- Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles.

SELECT
	DATE_TRUNC('day', lpep_pickup_datetime) pickup_day,
	MAX(trip_distance)
FROM
	green_taxi
WHERE
	trip_distance <100
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT 1;

-- Ans. 2025-11-14 (A)

-- Question 5. Biggest pickup zone
-- 
SELECT
	tz."Zone",
	COUNT(*)
FROM
	green_taxi gt
JOIN 
	taxi_zone tz
ON 
	tz."LocationID" = gt."PULocationID"
WHERE 
	date_trunc('day', gt."lpep_pickup_datetime") = '2025-11-18'
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT 1;

-- Ans. East Harlem North (A)

-- Question 6. Largest tip
-- For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?
WITH harlem as (
SELECT
	tz."Zone", 
	gt."DOLocationID",
	MAX(gt."tip_amount") max_tip
FROM
	green_taxi gt
JOIN 
	taxi_zone tz
ON 
	tz."LocationID" = gt."PULocationID"
WHERE 
	tz."Zone" = 'East Harlem North' 
	AND
	DATE_TRUNC('month', gt."lpep_pickup_datetime") = DATE_TRUNC('month', DATE '2025-11-01')
GROUP BY 1, 2
)

SELECT 
	tz."Zone", 
	h."max_tip"
FROM
	harlem h
JOIN 
	taxi_zone tz
ON 
	tz."LocationID" = h."DOLocationID"
ORDER BY 
	2 DESC
LIMIT 1;

-- Ans. Yorkville West (B)