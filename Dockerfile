# 1. Base Image (intentionally old/insecure)
FROM python:3.8-slim

# 2. Set working directory
WORKDIR /app

# 3. Copy requirements first (for cache)
COPY requirements.txt .

# 4. Install dependencies
RUN pip install -r requirements.txt

# 5. Copy remaining source code
COPY . .

# 6. Command to run the application
CMD ["flask", "run"]