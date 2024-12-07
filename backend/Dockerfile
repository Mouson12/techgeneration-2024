# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the entire project into the container at /app
COPY . /app


# Change to the specific folder containing your Flask app
WORKDIR /app

# Ensure wait-for-db.sh has execute permissions
RUN chmod +x /app/wait-for-db.sh

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the Flask app will run on
EXPOSE 5002

# Define environment variables
ENV FLASK_APP=server.py
ENV FLASK_RUN_PORT=5002

# Run the Flask app
CMD ["python", "server.py"]
