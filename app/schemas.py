from pydantic import BaseModel
from typing import List

class ErrorCreate(BaseModel):
    error_category: str
    error_subcategory: str
    error_frequency: int = 1

class UserWithErrors(BaseModel):
    username: str
    errors: List[ErrorCreate]

class ErrorResponse(BaseModel):
    id: int
    error_category: str
    error_subcategory: str
    error_frequency: int

    class Config:
        from_attributes = True

class UserResponse(BaseModel):
    id: int
    username: str
    errors: List[ErrorResponse]

    class Config:
        from_attributes = True