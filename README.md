# DTC-Data-Engineering

## Homework_1
#### Question 1. Understanding Docker images

```bash
docker run -it --entrypoint=bash python:3.13
```

Version of pip 

```bash
pip -V
pip 25.3 from /usr/local/lib/python3.13/site-packages/pip (python 3.13)
```

#### Question 2. Understanding Docker networking and docker-compose

```
postgres:5432
```

### Prepare the Data
#### Question 3. Counting short trips

```sql
SELECT 
	COUNT(lpep_pickup_datetime) pickup_count
FROM 
	green_taxi
WHERE
		lpep_pickup_datetime BETWEEN '2025-11-01' AND '2025-12-01'
	AND 
		trip_distance <= 1;
```

#### Question 4. Longest trip for each day
```sql
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
```

#### Question 5. Biggest pickup zone
```sql
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
```

#### Question 6. Largest tip
```sql
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
```


