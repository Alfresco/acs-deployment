FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY cd-init.py .
COPY data/ ./data/
CMD ["python", "./cd-init.py"]
