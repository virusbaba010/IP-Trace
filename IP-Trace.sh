#!/bin/bash

# Check if an IP address is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

# Get IP address from the command line argument
IP_ADDRESS=$1

# Fetch IP information using ipinfo.io
response=$(curl -s "http://ipinfo.io/${IP_ADDRESS}/json")

# Check if the response contains error
if echo "$response" | grep -q '"error"'; then
  echo "Error: Invalid IP address or unable to fetch information."
  exit 1
fi

# Parse and display the IP information
echo "IP Address: $(echo $response | jq -r '.ip')"
echo "City: $(echo $response | jq -r '.city')"
echo "Region: $(echo $response | jq -r '.region')"
echo "Country: $(echo $response | jq -r '.country')"
echo "Location: $(echo $response | jq -r '.loc')"
echo "Organization: $(echo $response | jq -r '.org')"
echo "Timezone: $(echo $response | jq -r '.timezone')"

exit 0
