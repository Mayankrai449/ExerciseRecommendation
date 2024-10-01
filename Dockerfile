FROM tiangolo/uvicorn-gunicorn-fastapi:python3.12.6

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN alembic revision --autogenerate -m "Automatic migration" || true
RUN alembic upgrade head

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
