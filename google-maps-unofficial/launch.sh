#!/bin/bash

# Define the BASE URL
BASE_URL="https://www.google.com/maps"
USER_AGENT="'Mozilla/5.0 ( Linux; Mobile; Ubuntu 20.04 Like Android 9 ) Firefox/140.0.2-1'"

# Define the base command for webapp-container
WEBAPP_COMMAND="webapp-container --app-id=\"google-maps-unofficial.chromiumos-guy\" --store-session-cookies --webapp-name=\"Google Maps\" --webappUrlPatterns='${BASE_URL},${BASE_URL}/*,https://*.google.com/*,https://*.gstatic.com/*,https://*.googleapis.com/*,https://maps.app.goo.gl/*' --user-agent-string=${USER_AGENT}"

# Get the URL passed as an argument (%u)
INPUT_URL="$1"

# Function to check if a URL is a valid GMaps URL
is_valid_url() {
    local url="$1"
    [[ "$url" =~ ^https://(maps\.app\.goo\.gl|maps\.google\.com)/.* ]]
}

# --- Main Logic ---

if [ -z "$INPUT_URL" ]; then
    # %u is empty, run the default command
    echo "No URL provided (%u is empty). Running default URL."
    eval "$WEBAPP_COMMAND $BASE_URL"
else
    # %u is not empty, check and process the URL
    if is_valid_url "$INPUT_URL"; then
        echo "Provided URL is valid using URL: $INPUT_URL"
        eval "$WEBAPP_COMMAND \"$INPUT_URL\""
    else
        echo "Provided URL is not valid: $INPUT_URL"
        echo "Running default URL."
        eval "$WEBAPP_COMMAND $BASE_URL"
    fi
fi
