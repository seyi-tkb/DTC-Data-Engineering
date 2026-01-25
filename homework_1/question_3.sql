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

-- Ans. 8007