FROM python:3.10-slim-buster
# Set working directory
WORKDIR /app
# Copy project files
COPY . /app/
# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
# Airflow configuration (NON-SENSITIVE only)
ENV AIRFLOW_HOME=/app/airflow
ENV AIRFLOW_CORE_DAGBAG_IMPORT_TIMEOUT=1000
ENV AIRFLOW_CORE_ENABLE_XCOM_PICKLING=True
# OS packages (minimal)
RUN apt update -y && apt install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*
# Make start script executable
RUN chmod +x start.sh
# Container entrypoint
ENTRYPOINT ["/bin/sh"]
CMD ["start.sh"]
