#!/bin/bash

# Script to retrieve the public IP address of a deployed Cloud Run service.

# Variables
LOG_FILE="scripts/get_public_ip.log"
SERVICE_NAME=$1
REGION=${2:-"us-central1"} # Default region if not provided

# Function to log messages with timestamps
log_message() {
  local MESSAGE=$1
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $MESSAGE" >> "$LOG_FILE"
}

# Check if service name is provided
if [ -z "$SERVICE_NAME" ]; then
  log_message "ERROR: Service name is required as an argument."
  echo "ERROR: Service name is required as an argument."
  exit 1
fi

# Log the start of the operation
log_message "Starting to retrieve public IP for service: $SERVICE_NAME in region: $REGION"

# Retrieve the public IP address of the Cloud Run service
PUBLIC_IP=$(gcloud run services describe "$SERVICE_NAME" --platform managed --region "$REGION" --format "value(status.address.url)" 2>> "$LOG_FILE")

# Check if the command was successful
if [ $? -ne 0 ]; then
  log_message "ERROR: Failed to retrieve public IP for service: $SERVICE_NAME"
  echo "ERROR: Failed to retrieve public IP. Check the log file for details."
  exit 1
fi

# Log and display the retrieved IP
log_message "Successfully retrieved public IP: $PUBLIC_IP"
echo "Public IP: $PUBLIC_IP"
