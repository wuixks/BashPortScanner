#!/bin/bash

# CPSC 42700-002 Project 1
# Michael Wallin Feb 4, 2025
# Bash port scanner

timeout=2

# Function to display usage
usage() {
    echo "Usage: ./portscanner.sh [-t timeout] [host startport stopport]"
    exit 1
}

# Check the number of arguments
if [ "$#" -ne 0 ] && [ "$#" -ne 2 ] && [ "$#" -ne 3 ] && [ "$#" -ne 5 ]; then
    usage
fi

# Check for -t option for timeout and adjust it if present
if [ "$1" == "-t" ]; then
    timeout="$2"
    shift 2
    echo "Timeout changed to $timeout"
fi

# Function to perform the scanning
function prompts {
    local host=$1
    local startport=$2
    local stopport=$3

    function pingcheck {
        # Run a ping command and scrape its output to see if it succeeded.
        pingresult=$(ping -c 1 "$host" | grep bytes | wc -l)

        if [ "$pingresult" -gt 1 ]; then
            echo "$host is up"
        else
            echo "$host is down, quitting"
            exit
        fi
    }

    function portcheck {
        for ((counter=startport; counter <= stopport; counter++)); do
            if timeout "$timeout" bash -c "echo > /dev/tcp/$host/$counter"; then
                echo "$counter is open"
            else
                echo "$counter is closed"
            fi
        done
    }

    pingcheck
    portcheck
}

# Interactive mode if no arguments are passed
if [ "$#" -eq 0 ]; then
    echo "No hostname provided. Enter hostname, start port, and stop port."
    while true; do
        read -p "Enter hostname (or press Enter to quit): " host
        if [ -z "$host" ]; then
            break
        fi
        read -p "Enter start port: " startport
        read -p "Enter stop port: " stopport
        prompts "$host" "$startport" "$stopport"
    done
else
    # Process command line arguments for host and ports
    if [ "$#" -eq 2 ]; then
        host=$1
        startport=$2
        stopport=$2  # If only 2 arguments are given, set stopport to startport
    elif [ "$#" -eq 3 ]; then
        host=$1
        startport=$2
        stopport=$3
    elif [ "$#" -eq 5 ]; then
        host=$2
        startport=$3
        stopport=$4
    fi

    prompts "$host" "$startport" "$stopport"
fi
