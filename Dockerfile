# Use a Python image
FROM python:3.8-slim

# Set the working directory inside the Docker container
WORKDIR /app

# Copy everything in your project directory to the Docker container
COPY . /app

# Install the Python packages listed in requirements.txt
RUN pip install -r requirements.txt

# Open port 80 to allow communication with the container
EXPOSE 80

# Run your app.py file when the container starts
CMD ["python", "app.py"]
