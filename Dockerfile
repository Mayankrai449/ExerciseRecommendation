FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN alembic init alembic

RUN sed -i '/# target_metadata = mymodel.Base.metadata/a \
from app.db.models import Base\n\
from dotenv import load_dotenv\n\
import os\n\
\n\
load_dotenv()\n\
\n\
DATABASE_URL = os.getenv("DATABASE_URL")\n\
\n\
from alembic import context\n\
\n\
config = context.config\n\
\n\
if config.config_file_name is not None:\n\
    fileConfig(config.config_file_name)\n\
\n\
target_metadata = Base.metadata\n\
\n\
config.set_main_option("sqlalchemy.url", DATABASE_URL)' alembic/env.py

RUN mkdir -p alembic/versions


EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
