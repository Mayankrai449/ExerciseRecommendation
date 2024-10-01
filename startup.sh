set -e

alembic revision --autogenerate -m "Automatic migration" || true
alembic upgrade head

exec uvicorn main:app --host 0.0.0.0 --port 8000