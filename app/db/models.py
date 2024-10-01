from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.orm import DeclarativeBase

class Base(DeclarativeBase):
    pass

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True, nullable=False)

class Error(Base):
    __tablename__ = "errors"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    error_category = Column(String, nullable=False)
    error_subcategory = Column(String, nullable=False)
    error_frequency = Column(Integer, default=1)

    user = relationship("User", back_populates="errors")

User.errors = relationship("Error", back_populates="user")
