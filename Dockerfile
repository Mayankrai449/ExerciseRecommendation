FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

COPY startup.sh .
RUN chmod +x startup.sh

CMD ["/app/startup.sh"]