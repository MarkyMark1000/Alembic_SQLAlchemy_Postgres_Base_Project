from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import DeclarativeBase


class Base(DeclarativeBase):
    """Base class for all tables."""

    pass


metadata = Base.metadata


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    email = Column(String)

    def __str__(self):
        return f"User: {self.id}, {self.email}"
