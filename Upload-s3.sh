#!/bin/bash

# Replace these values with your own
S3_BUCKET="s3://url"
LOCAL_FOLDER="YOUR_LOCAL_PATH"

# Check if the AWS CLI is installed
command -v aws >/dev/null 2>&1 || { echo >&2 "AWS CLI is not installed. Aborting."; exit 1; }

# Iterate over each file in the local folder and upload to S3
for file in "$LOCAL_FOLDER"/*
do
    if [ -f "$file" ]; then
        echo "Uploading $file to S3 bucket: $S3_BUCKET"
        aws s3 cp "$file" "$S3_BUCKET/$(basename "$file")"
        echo "Upload complete."
    fi
done

echo "All files uploaded successfully."
