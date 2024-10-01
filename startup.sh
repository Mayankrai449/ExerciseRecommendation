#!/bin/bash
set -e

# Always remove existing migration files
echo "Removing existing migration files."
rm -rf /app/alembic/versions/*

# Always stamp the database to the base revision
echo "Stamping the database to the base revision."
alembic stamp base

# Create a new initial migration
echo "Creating a new initial migration."
alembic revision --autogenerate -m "Initial migration"

# Upgrade to the latest migration
echo "Upgrading the database to the latest migration."
alembic upgrade head

# Start the application
echo "Starting the application."
exec uvicorn app.main:app --host 0.0.0.0 --port 8000
