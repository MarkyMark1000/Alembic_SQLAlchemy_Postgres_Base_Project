# Alembic_SQLAlchemy_Postgres_Base_Project

## Initiating the Environment

Build the dockerfile:
```
docker compose build test_project
```

Initiate the environment
```
docker compose up -d
```

Connect to the container:
```
docker compose run --service-ports test_project bash
```

## Create a database

This can be achieved using either a database admin tool or psql:
```
psql -U postgres -h host.docker.internal -p 5432            # connect to the db
\l                                                          # list tables
create database test_db;                                    # create test_db
\q                                                          # exit psql
```

## Migrations

To run migrations:
```
alembic upgrade head
```

To downgrade by 1 migration:
```
alembic downgrade -1
```

To autogenerate a migration script:
```
alembic revision -m "create new table" --autogenerate
```

