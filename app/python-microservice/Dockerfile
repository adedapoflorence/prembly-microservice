# Stage 1: Build Python Application
FROM python:3.9 AS build

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2: Create Lightweight Production Image
FROM python:3.9-slim AS production

WORKDIR /app

# Copy only necessary files from the build stage
COPY --from=build /app .

# Install only production dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port on which your Flask app will run
EXPOSE 5000

# Command to run your application
CMD ["python", "app.py"]

# Additional optimization: Remove unnecessary build dependencies
RUN apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*
