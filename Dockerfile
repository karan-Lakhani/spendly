FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn

COPY . .

# Run as non-root. /app must be writable so the SQLite file can be created later.
RUN useradd --create-home appuser && chown -R appuser /app
USER appuser

EXPOSE 5001

# app.py's app.run() binds to 127.0.0.1, so serve with gunicorn on 0.0.0.0 instead.
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "--workers", "2", "app:app"]
