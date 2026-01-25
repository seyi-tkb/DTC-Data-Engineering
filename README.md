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

