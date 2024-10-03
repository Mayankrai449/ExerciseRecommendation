from fastapi import FastAPI
from app.api import mock_data, exercise

app = FastAPI()

@app.head("/health")
@app.get("/health")
def health():
    return {"status": "ok"}

app.include_router(mock_data.router)
app.include_router(exercise.router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="127.0.0.1", port=8000, reload=True)