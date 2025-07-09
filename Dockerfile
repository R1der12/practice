FROM python:3.11-slim

WORKDIR /app
COPY app/app.py ./app.py
COPY app/requirements.txt ./requirements.txt
COPY app/templates ./templates
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python", "app.py"]