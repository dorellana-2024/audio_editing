# Use an official Python image
FROM python:3.10-slim

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Prevent Python from writing pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies (ffmpeg -> pydub)
RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first (Docker cache optimization)
COPY requirements.in .
COPY requirements.txt .

# Update pip
RUN pip install --upgrade pip 

# Instalar dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Default command
CMD ["python", "main.py"]
