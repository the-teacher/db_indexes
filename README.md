# Project to play with DB Indexes

### How to start

```sh
$ docker compose -f docker-compose.yml up
```

### How to get in PSQL container

```sh
$ docker exec -ti db_indexes-psql-1 bash
```

### How to get in PSQL

```sh
psql --host=localhost --username=postgres
```

### How to list DB tables

```psql
postgres=# \l
```

```
                                                List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider |   Access privileges
-----------+----------+----------+------------+------------+------------+-----------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
```

### How to quit PSQL

```
postgres=# \q
```
