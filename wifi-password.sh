#!/bin/bash

# This script was created as a learning exercise in bash scripting.
# It demonstrates several important concepts:
# 1. Shebang line and script structure
# 2. Function definitions and usage
# 3. Command-line argument parsing
# 4. Error handling and verbose output
# 5. Using system commands to retrieve network information
# 6. Interacting with the macOS Keychain
#
# The script is designed to work on macOS and retrieves the password
# of the currently connected Wi-Fi network. It includes error checking
# and verbose output options for educational purposes.

set -e  # Exit immediately if a command exits with a non-zero status

# Global variables
VERBOSE=false

# Function to print usage information
# This function demonstrates how to create a multi-line string in bash
# and how to use cat with a here-document for printing formatted text
print_usage() {
    cat << EOF
Usage: $0 [options]

Options:
  -h, --help     Show this help message and exit
  -v, --verbose  Enable verbose output

Description:
  This script retrieves and displays the password of the currently connected Wi-Fi network on macOS.
EOF
}

# Function to print verbose messages
# This function demonstrates conditional execution based on a boolean variable
# It also shows how to redirect output to stderr for informational messages
verbose() {
    if [ "$VERBOSE" = true ]; then
        echo "$@" >&2
    fi
}

# Function to check if the script is running on macOS
# This function demonstrates how to use the uname command to check the operating system
# and how to exit the script with an error message if a condition is not met
check_os() {
    if [[ "$(uname)" != "Darwin" ]]; then
        echo "Error: This script only works on macOS." >&2
        exit 1
    fi
}

# Function to get the current Wi-Fi network name
# This function demonstrates how to use system commands (networksetup) to get network information
get_current_wifi() {
    local wifi_name
    wifi_name=$(networksetup -getairportnetwork en0 | awk -F': ' '{print $2}')
    if [[ -z "$wifi_name" ]]; then
        echo "Error: Not connected to any Wi-Fi network." >&2
        exit 1
    fi
    echo "$wifi_name"
}

# Function to retrieve the Wi-Fi password
# This function demonstrates how to interact with the macOS Keychain using the security command
get_wifi_password() {
    local wifi_name="$1"
    local password
    password=$(security find-generic-password -D "AirPort network password" -a "$wifi_name" -w 2>&1)
    if [[ $? -ne 0 ]]; then
        echo "Error: Unable to retrieve password for $wifi_name. You may need to run this script with sudo." >&2
        exit 1
    fi
    echo "$password"
}

# Main function
# The main logic of a script
# and how to use other functions to perform specific tasks
main() {
    check_os
    verbose "Checking current Wi-Fi..."
    current_wifi=$(get_current_wifi)
    verbose "Current Wi-Fi: '$current_wifi'"
    verbose "Retrieving password..."
    password=$(get_wifi_password "$current_wifi")
    echo "The password for '$current_wifi' is: $password"
}

# Parse command-line options
# This section demonstrates how to parse command-line arguments in bash
# It uses a while loop and case statement to handle different options
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            print_usage
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            echo "Unknown option: $1" >&2
            print_usage
            exit 1
            ;;
    esac
done

main
