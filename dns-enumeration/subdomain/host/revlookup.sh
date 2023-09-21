#!/bin/bash

# Author: 0xA

color_enabled=true    # Default: Enable color
output_file=""        # Default: No output file specified
subnet=24             # Default: /24 subnet

# ANSI escape codes for text colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'  # Reset color

while [[ $# -gt 0 ]]; do
    case "$1" in
        --no-color)
            color_enabled=false
            shift
            ;;
        -o|--output)
            if [ $# -ge 2 ]; then
                output_file="$2"
                shift 2
            else
                echo "Error: Missing argument for -o|--output option."
                exit 1
            fi
            ;;
        -a|--address)
            if [ $# -ge 2 ]; then
                ip_address="$2"
                shift 2
            else
                echo "Error: Missing argument for -a|--address option."
                exit 1
            fi
            ;;
        *)
            break
            ;;
    esac
done

if [ -z "$ip_address" ]; then
    echo "Error: IP address not specified."
    exit 1
fi

# Check if the output file is specified and create it if it doesn't exist
if [[ -n "$output_file" ]]; then
    touch "$output_file"  # Create or update the file
fi

# Extract the first three octets from the IP address
ip_prefix=$(echo "$ip_address" | awk -F'.' '{print $1"."$2"."$3}')

for ((i = 0; i <= 254; i++)); do
    ip="$ip_prefix.$i"
    result=$(host "$ip")
    if [ $? -eq 0 ] && [[ "$result" == *"domain name pointer"* ]]; then
        # Successful result (exit status 0) with "domain name pointer" in output
        subdomain=$(echo "$result" | sed -n 's/.*domain name pointer \(.*\)\.$/\1/p')
        if $color_enabled; then
            result="${GREEN}$result$NC"
        fi
        if [[ -n "$output_file" ]]; then
            echo "$subdomain" >> "$output_file"
        fi
    elif $color_enabled; then
        # Unsuccessful result (exit status non-zero)
        result="${RED}$result$NC"
    fi

    echo -e "$result"
done
