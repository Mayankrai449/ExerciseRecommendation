from fastapi import FastAPI
from app.api import mock_data, exercise

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

app.include_router(mock_data.router)
app.include_router(exercise.router)