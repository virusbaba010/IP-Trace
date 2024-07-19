#!/bin/bash

# Check if an IP address is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

# Get IP address from the command line argument
IP_ADDRESS=$1

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "Error: curl is not installed. Please install curl."
  echo "To install curl sudo 'apt-get install curl'"
  exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "Error: jq is not installed. Please install jq."
  echo "To install curl sudo 'apt-get install jq'"
  exit 1
fi


response=$(curl -s "http://ip-api.com/json/${IP_ADDRESS}")

# Check if the response contains an error
# Response error or it will continue the script
if echo "$response" | jq -e '.status' | grep -q 'fail'; then
  echo "Error: Invalid IP address or unable to fetch information."
  echo "Please check IP address and try again !"
  exit 1
fi

# Parse and display the IP information
echo "IP Address: $(echo "$response" | jq -r '.query')"
echo "City: $(echo "$response" | jq -r '.city')"
echo "Region: $(echo "$response" | jq -r '.regionName')"
echo "Country: $(echo "$response" | jq -r '.country')"
echo "Location: $(echo "$response" | jq -r '.lat'), $(echo "$response" | jq -r '.lon')"
echo "Organization: $(echo "$response" | jq -r '.org')"
echo "Timezone: $(echo "$response" | jq -r '.timezone')"
echo "Address: $(echo "$response" | jq -r '.address')"
echo "Name: $(echo "$response" | jq -r '.name')"

exit 0
