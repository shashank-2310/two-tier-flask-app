# Base Image
FROM python:3.13-slim

# Working directory
WORKDIR /app

# Install sytem dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements into container
COPY requirements.txt .

# Install app deps
RUN pip install mysqlclient && pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Serve the app
CMD ["python","app.py"]
