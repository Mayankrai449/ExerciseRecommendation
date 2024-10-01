FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

COPY startup.sh .
RUN sed -i 's/\r$//' startup.sh && \
    chmod +x startup.sh

CMD ["/bin/bash", "/app/startup.sh"]