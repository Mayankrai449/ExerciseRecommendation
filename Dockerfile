FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/alembic/versions

EXPOSE 8000

RUN sed -i 's/\r$//' startup.sh && \
    chmod +x startup.sh

CMD ["/bin/bash", "/app/startup.sh"]