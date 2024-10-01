#!/bin/bash
set -e

# Check if there are any existing migration files
if [ -z "$(ls -A /app/alembic/versions)" ]; then
    echo "No existing migrations found. Creating a new initial migration."
    # Remove any existing migration data from the database
    alembic stamp base
    # Create a new migration
    alembic revision --autogenerate -m "Initial migration"
else
    echo "Existing migrations found. Attempting to upgrade."
    # Try to upgrade, if it fails, we'll reset
    alembic upgrade head || {
        echo "Migration failed. Resetting migration state."
        # Remove existing migration files
        rm /app/alembic/versions/*
        # Remove migration data from the database
        alembic stamp base
        # Create a new initial migration
        alembic revision --autogenerate -m "Fresh initial migration"
    }
fi

# Always try to upgrade at the end
alembic upgrade head

# Start the application
exec uvicorn app.main:app --host 0.0.0.0 --port 8000