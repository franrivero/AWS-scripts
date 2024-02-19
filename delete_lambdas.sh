#!/bin/bash

# This script deletes your lambdas function based on 'FB-' nomenclature.
# Set your AWS region
AWS_REGION="your_region"

# Set the start and end dates in the format YYYY-MM-DD
START_DATE="2023-03-01"
END_DATE="2023-10-03"

# Get a list of Lambda function names and their creation dates
function_list=$(aws lambda list-functions --region $AWS_REGION --query "Functions[?LastModified>='$START_DATE' && LastModified<='$END_DATE'].FunctionName" --output json | grep 'FB-')
echo $function_list
if [ -n "$function_list" ]; then
  echo "Lambda functions to delete:"
  echo "$function_list"
fi
Check if any functions were found
if [ -n "$function_list" ]; then
  # Iterate over the function names and delete each one
  for function_name in $(echo "$function_list" | jq -r '.[]'); do
    echo "Deleting Lambda function: $function_name"
    aws lambda delete-function --region $AWS_REGION --function-name $function_name
  done
else
  echo "No Lambda functions with names containing 'FB-' found between $START_DATE and $END_DATE."
fi
