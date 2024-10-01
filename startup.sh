#!/bin/bash
set -e

# Run Alembic migrations
alembic revision --autogenerate -m "Automatic migration" || true
alembic upgrade head

# Start the application
exec uvicorn app.main:app --host 0.0.0.0 --port 8000