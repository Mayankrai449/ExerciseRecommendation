from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.models import *
from app.db.config import get_db
from app.schemas import *

router = APIRouter()

@router.post("/add_mock/", response_model=UserResponse)
def add_user_with_errors(user_data: UserWithErrors, db: Session = Depends(get_db)):
    try:
        user = db.query(User).filter(User.username == user_data.username).first()
        
        if not user:
            user = User(username=user_data.username)
            db.add(user)
            db.commit()
            db.refresh(user)

        for error_data in user_data.errors:
            error = Error(
                user_id=user.id,
                error_category=error_data.error_category,
                error_subcategory=error_data.error_subcategory,
                error_frequency=error_data.error_frequency
            )
            db.add(error)
        
        db.commit()
        db.refresh(user)
        
        return user

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))