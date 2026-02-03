
### Understanding Docker images
#### Question 1. What's the version of pip in the python:3.13 image? 
- 25.3
- 24.3.1
- 24.2.1
- 23.3.1

```bash
docker run -it --entrypoint=bash python:3.13
```

To check version of pip, run:

```bash
pip -V
(Response) pip 25.3 from /usr/local/lib/python3.13/site-packages/pip (python 3.13)
```
Answer: The version of pip is 25.3


### Understanding Docker networking and docker-compose
#### Question 2. Given the docker-compose.yaml, what is the hostname and port that pgadmin should use to connect to the postgres database?
- postgres:5433
- localhost:5432
- db:5433
- postgres:5432
- db:5432

```
postgres:5432
```
Answer: postgres:5432


### Prepare the Data
#### Question 3. For the trips in November 2025, how many trips had a trip_distance of less than or equal to 1 mile? (1 point)
- 7,853
- 8,007
- 8,254
- 8,421

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
Answer: 8,007


#### Question 4. Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles. 
- 2025-11-14
- 2025-11-20
- 2025-11-23
- 2025-11-25

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
Answer: 2025-11-14


#### Question 5. Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025? (1 point)
- East Harlem North
- East Harlem South
- Morningside Heights
- Forest Hills

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
Answer: East Harlem North


#### Question 6. For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip? (1 point)
- JFK Airport
- Yorkville West
- East Harlem North
- LaGuardia Airport

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
Answer: Yorkville West


#### Question 7. Which of the following sequences describes the Terraform workflow for: `1.` Downloading plugins and setting up backend, `2.` Generating and executing changes, `3.` Removing all resources? 
- terraform import, terraform apply -y, terraform destroy
- teraform init, terraform plan -auto-apply, terraform rm
- terraform init, terraform run -auto-approve, terraform destroy
- terraform init, terraform apply -auto-approve, terraform destroy
- terraform import, terraform apply -y, terraform rm

Answer: terraform init, terraform apply -auto-approve, terraform destroy