# Exercise Recommendation API

This assignment provides an API endpoint to fetch the top N most frequent errors for a user based on their conversation history. It's designed to support an English learning platform where users receive feedback on Grammar, Vocabulary, Pronunciation, and Content/Fluency.

## Features

- RESTful API endpoint `/generate-exercise` to fetch top errors
- RESTful API endpoint `/mock-data` to upload mock data for errors and users
- Configurable number of errors to return
- Error categorization by main category and subcategory
- Frequency-based sorting of errors
- Database migration support using Alembic

## Getting Started

### Prerequisites

- Python 3.12.6 or higher
- PostgreSQL database
- pip (Python package manager)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Mayankrai449/ExerciseRecommendation.git
cd ExerciseRecommendation
```

2. Create and activate a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows, use: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Create a `.env` file in the project root and add your database URL:
```
DATABASE_URL=postgresql://your_username:your_password@localhost:5432/dbname
```

### Database Setup

1. Create a new database in PostgreSQL:
```sql
CREATE DATABASE your_database_name;
```

2. Initialize Alembic:
```bash
alembic init alembic
```

3. Update `alembic/env.py` with the following at the top of the file:
```python
from app.db.models import Base
from dotenv import load_dotenv
import os

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
target_metadata = Base.metadata

config.set_main_option('sqlalchemy.url', DATABASE_URL)
```

4. Generate and run migrations:
```bash
alembic revision --autogenerate -m "Initial migration"
alembic upgrade head
```

### Running the API

Start the API server:
```bash
uvicorn app.main:app --reload
```

The API will be available at `http://localhost:8000`

## API Documentation

### GET /generate-exercise

Fetches the top N most frequent errors for a specific user.

**Request**

```
GET /generate-exercise?user_id=1&limit=3
```

Parameters:
- `user_id` (required): The ID of the user
- `limit` (optional): Number of top errors to return (default: 10)

**Response**

```json
[
  {
    "errorCategory": "Grammar",
    "errorSubCategory": "Adverb",
    "errorFrequency": 10
  },
  {
    "errorCategory": "Pronunciation",
    "errorSubCategory": "MisPronounced_Syllable",
    "errorFrequency": 8
  }
]
```

## Database Schema

The API uses the following main tables:

1. `users` - Stores user information
2. `errors` - Stores error occurrences with categories, subcategories and frequencies

