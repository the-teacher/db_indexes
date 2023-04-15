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
