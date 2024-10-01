from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.models import Error, User
from app.db.config import get_db
from app.schemas import ErrorOut
from typing import List, Dict

router = APIRouter()

@router.get("/generate-exercise", response_model=List[Dict[str, List[ErrorOut]]])
def generate_exercise(user_id: int, n: int = 3, db: Session = Depends(get_db)):
    
    user = db.get(User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found.")
    
    errors = db.query(Error).filter(Error.user_id == user_id).order_by(Error.error_frequency.desc()).limit(n).all()

    if not errors:
        raise HTTPException(status_code=404, detail="No errors found for this user.")

    response = [{"top_errors": [ErrorOut.model_validate(error) for error in errors]}]
    
    return response
