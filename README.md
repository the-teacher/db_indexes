# Project to play with DB Indexes

### How to start

```sh
$ docker compose -f docker-compose.yml up
```

### How to get in containers

```sh
$ docker exec -ti db_indexes-psql-1 bash

$ docker exec -ti db_indexes-rails-1 bash
```

### How to get in PSQL

```sh
psql --host=localhost --username=postgres
```

### How to list DB tables

```psql
postgres=# \l
```

```sh
                                                List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider |   Access privileges
-----------+----------+----------+------------+------------+------------+-----------------+-----------------------
 db_indexes| postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
```

### How to quit PSQL

```sh
postgres=# \q
```

### How to create Database

```sh
$ docker exec -ti db_indexes-rails-1 bash
```

```sh
rake db:create
rake db:migrate
rake db:seed
```

### Use PSQL database

```sh
$ docker exec -ti db_indexes-psql-1 bash
```

```sh
postgres=# \c db_indexes
You are now connected to database "db_indexes" as user "postgres".
```

```sh
db_indexes-# \dt
                List of relations
 Schema |         Name         | Type  |  Owner
--------+----------------------+-------+----------
 public | ar_internal_metadata | table | postgres
 public | schema_migrations    | table | postgres
 public | users                | table | postgres
(3 rows)
```

### Count Table rows


```sql
SELECT COUNT(*) as "Count of Rows" from users;

 Count of Rows
---------------
        293779
```

```sql
SELECT COUNT(*) from users;

 count
--------
 295090
(1 row)
```

### Explain Simple Example

```sql
EXPLAIN SELECT COUNT(*) from users;
EXPLAIN (FORMAT JSON) SELECT COUNT(*) from users;
EXPLAIN (FORMAT YAML) SELECT COUNT(*) from users;

EXPLAIN SELECT COUNT(DISTINCT id) from users;
EXPLAIN (FORMAT YAML) SELECT COUNT(DISTINCT id) from users;

EXPLAIN ANALYZE SELECT COUNT(*) from users;
EXPLAIN ANALYZE SELECT COUNT(id) from users;
EXPLAIN ANALYZE SELECT COUNT(DISTINCT id) from users;
```

### Select

```sh
# SELECT * from users WHERE id=100000;

id | login | name | email | country | created_at | updated_at

100000 | bauch.garry.v | Garry Bauch V | v.bauch.garry@campaign-archive.com | Congo | 2023-04-15 14:47:38.110485 | 2023-04-15 14:47:38.110485

(1 row)
```

```sh
# \x on
Expanded display is on.
```

```sh
SELECT * from users WHERE id=100000;

-[ RECORD 1 ]----------------------------------
id         | 100000
login      | bauch.garry.v
name       | Garry Bauch V
email      | v.bauch.garry@campaign-archive.com
country    | Congo
created_at | 2023-04-15 14:47:38.110485
updated_at | 2023-04-15 14:47:38.110485
```

### Selects

```sql
SELECT COUNT(*) from users WHERE country='Congo';
SELECT COUNT(*) from users WHERE country='Greece';
SELECT COUNT(*) from users WHERE country='Russian Federation';

EXPLAIN ANALYZE SELECT COUNT(*) from users WHERE country='Congo';
EXPLAIN ANALYZE SELECT COUNT(*) from users WHERE country='Greece';
EXPLAIN (ANALYZE, FORMAT YAML) SELECT COUNT(*) from users WHERE country='Russian Federation';

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) SELECT COUNT(*) from users WHERE country='Congo';
```

```sh
   Planning Time: 0.673 ms
   Execution Time: 71.575 ms

   Startup Cost: 21901.03
   Total Cost: 21901.04

   Workers Planned: 2
   Workers Launched: 2

   Partial Aggregate + Parallel Seq Scan
   Filter: ((country)::text = 'Greece'::text)
```

### Output to a file and back

```
db_indexes=# \o '/query-result.txt'
db_indexes=# \o
```

### Pager (skipping lines)

```
\pset pager off
\pset pager on
```

### SELECT with LIKE

```sql
SELECT * from users WHERE name LIKE 'Anissa%' LIMIT 2;
```

```
-[ RECORD 1 ]---------------------------
id         | 803272
login      | anissa.tremblay
name       | Anissa Tremblay
email      | anissa.tremblay@gmx.fr
country    | Serbia
created_at | 2023-04-15 23:10:10.683522
updated_at | 2023-04-15 23:10:10.683522
-[ RECORD 2 ]---------------------------
id         | 807338
login      | anissa-shanahan
name       | Anissa Shanahan
email      | anissa.shanahan@yopmail.com
country    | Guam
created_at | 2023-04-15 23:13:10.224406
updated_at | 2023-04-15 23:13:10.224406
```

```sql
SELECT * from users WHERE email LIKE '%gmail%' LIMIT 2;
SELECT COUNT(*) from users WHERE email LIKE '%gmail%' LIMIT 2;
```

```sql
EXPLAIN ANALYZE SELECT * from users WHERE email LIKE '%gmail%' ORDER BY name ASC LIMIT 2;
```

```
 Limit  (cost=21897.00..21897.23 rows=2 width=92) (actual time=93.633..97.930 rows=2 loops=1)
   ->  Gather Merge  (cost=21897.00..21906.80 rows=84 width=92) (actual time=93.587..97.882 rows=2 loops=1)
         Workers Planned: 2
         Workers Launched: 2
         ->  Sort  (cost=20896.98..20897.08 rows=42 width=92) (actual time=69.580..69.581 rows=2 loops=3)
               Sort Key: name
               Sort Method: top-N heapsort  Memory: 25kB
               Worker 0:  Sort Method: top-N heapsort  Memory: 25kB
               Worker 1:  Sort Method: top-N heapsort  Memory: 25kB
               ->  Parallel Seq Scan on users  (cost=0.00..20896.56 rows=42 width=92) (actual time=0.108..68.122 rows=6735 loops=3)
                     Filter: ((email)::text ~~ '%gmail%'::text)
                     Rows Removed by Filter: 327433

 Planning Time: 1.137 ms
 Execution Time: 98.150 ms

(14 rows)
```

### SELECT with LIKE

```sql
SELECT * from users WHERE name LIKE 'B%' AND email LIKE '%gmail%' ORDER BY name ASC LIMIT 2;
EXPLAIN ANALYZE SELECT * from users WHERE name LIKE 'B%' AND email LIKE '%gmail%' ORDER BY name ASC LIMIT 2;
```

```
 Limit  (cost=22941.51..22941.51 rows=2 width=92) (actual time=72.121..78.170 rows=2 loops=1)
   ->  Sort  (cost=22941.51..22941.52 rows=4 width=92) (actual time=72.117..78.165 rows=2 loops=1)
         Sort Key: name
         Sort Method: top-N heapsort  Memory: 25kB
         ->  Gather  (cost=1000.00..22941.47 rows=4 width=92) (actual time=5.076..77.805 rows=787 loops=1)
               Workers Planned: 2
               Workers Launched: 2
               ->  Parallel Seq Scan on users  (cost=0.00..21941.07 rows=2 width=92) (actual time=2.019..50.701 rows=262 loops=3)
                     Filter: (((name)::text ~~ 'B%'::text) AND ((email)::text ~~ '%gmail%'::text))
                     Rows Removed by Filter: 333906
 Planning Time: 0.594 ms
 Execution Time: 78.306 ms
 ```

### Turn on/off Timing

```psql
\timing
```

### Resources

- https://habr.com/ru/companies/postgrespro/articles/326096/
- https://www.youtube.com/watch?v=aaecM4wKdhY
- https://explain.dalibo.com/
