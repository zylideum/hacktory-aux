#!/bin/bash

# Author: 0xA

filter_results=false  # Default: Do not filter results
color_enabled=true    # Default: Enable color
output_file=""        # Default: No output file specified

# ANSI escape codes for text colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'  # Reset color

while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--filter)
            filter_results=true
            shift
            ;;
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
        *)
            break
            ;;
    esac
done

if [ $# -ne 2 ]; then
    echo "Usage: $0 [-f|--filter] [--no-color] [-o|--output <output_file>] <domain> <wordlist_file>"
    exit 1
fi

domain="$1"
wordlist="$2"

if [ ! -f "$wordlist" ]; then
    echo "Error: Wordlist file '$wordlist' not found."
    exit 1
fi

# Check if the output file is specified and create it if it doesn't exist
if [[ -n "$output_file" ]]; then
    touch "$output_file"  # Create or update the file
fi

while IFS= read -r ip; do
    result=$(host "$ip.$domain")
    if $color_enabled; then
        if [[ "$result" == *"has address"* || "$result" == *"has IPv6"* ]]; then
            result="${result//has address/$GREEN&$NC}"
            result="${result//has IPv6 address/$GREEN&$NC}"
            if [[ -n "$output_file" ]]; then
                subdomain="${ip}.$domain"
                echo "$subdomain" >> "$output_file"
            fi
        elif [[ "$result" == *"not found"* ]]; then
            result="${RED}$result$NC"
        fi
    fi

    if ! $filter_results || [[ "$result" != *"not found"* ]]; then
        echo -e "$result"
    fi
done < "$wordlist"
