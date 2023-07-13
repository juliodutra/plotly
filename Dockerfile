# Use the official Python image as the base image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file to the working directory
COPY requirements.txt .

# Install the Python dependencies
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y python3-dev && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the userapi.py file to the working directory
COPY userapi.py .

# Expose the port that the Flask application will be running on
EXPOSE 5000

# Set the arguments variables
ARG YOUR_DB_ROOT_PASSWORD=p4ssw0rd
ARG YOUR_DB_NAME=plotly
ARG YOUR_MYSQL_SERVICE_HOST=127.0.0.1
ARG YOUR_MYSQL_SERVICE_PORT=3306

# Set the environment variables for the Flask application
ENV db_root_password $YOUR_DB_ROOT_PASSWORD
ENV db_name $YOUR_DB_NAME
ENV MYSQL_SERVICE_HOST $YOUR_MYSQL_SERVICE_HOST
ENV MYSQL_SERVICE_PORT $YOUR_MYSQL_SERVICE_PORT

# Start MySQL server and run the Flask application
CMD service mysql start && python userapi.py
