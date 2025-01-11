# Tutorial

This is intended to be a base file that can be expanded and turned into a tutorial.

Currently it contains an explanation of how the current environment was setup.

## Initial Setup

Please note that basic code formatting tools such as black, isort and flake8 have been
provided, but no configuration files have been created.

Create a models directory and add a file called tables.py

Add the following code to the tables.py file:
```
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy import Column, Integer, String

class Base(DeclarativeBase):
    """Base class for all tables."""

    pass

metadata = Base.metadata

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    email = Column(String)

    def __str__(self):
        return f"User: {self.id}, {self.email}"

```

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

## Setting up alembic

Setup alembic
```
alembic init alembic
```

Within the alembic.ini file adjust, update the path to the database
```
sqlalchemy.url = postgresql+psycopg2://postgres:password@db:5432/test_db
```

Update env.py within alembic to reflect these change:
```
# import tables
import models.tables as td

# adjust target_metadata
target_metadata = td.metadata
```

## Creating a database to use

It is possible to do this within an environment such as pgAdmin.   I have provided the
commands necessary to connect to the database, list databases, create a database and then
quit psql:
```
psql -U postgres -h host.docker.internal -p 5432            # connect to the db
\l                                                          # list tables
create database test_db;                                    # create test_db
\q                                                          # exit psql
```

## Running the first migration

To generate the first migration file within alembic, use the following command:
```
alembic revision -m "first migration - create users" --autogenerate
```

This should create a new migration file within the alembic/versions directory.   Update
the database with this migration:
```
alembic upgrade head
```

## Checking the database

Within the new test_db database, this should have created a new 'users' table
and a 'alembic_version' table.   The 'alembic_version' table is used by alembic to
store information on the migrations and the 'users' table reflects the class within
the tables.py file that we have just created.

This can be checked within an environment such as pgAdmin or using psql:
```
psql -U postgres -h host.docker.internal -p 5432            # connect to the db
\l                                                          # list tables
\c test_db;                                                 # switch to test_db
\dt                                                         # list tables
\q                                                          # exit psql
```