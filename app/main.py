from fastapi import FastAPI
from app.api import mock_data

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

app.include_router(mock_data.router)