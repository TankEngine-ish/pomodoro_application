#!/bin/bash

# Check if Zenity and at are installed
if ! command -v zenity &> /dev/null || ! command -v at &> /dev/null; then
    echo "Zenity and at are required but not installed. Please install them and try again."
    exit 1
fi


# Initialize variables
music_enabled=true
music_file="/path/to/your/music/file.mp3"  # Replace with the path to your music file


# Main loop
while true; do
    # Show main dialog
    action=$(zenity --list --title="Pomodoro Timer" --column="Actions" "Start" "Stop/Pause" "Reset" "Skip Break" "Disable/Enable Music" "Exit")

    case $action in
        "Start")
            # Schedule tasks
            ;;
        "Stop/Pause")
            # Remove all scheduled tasks
            ;;
        "Reset")
            # Remove all scheduled tasks and show the main dialog again
            ;;
        "Skip Break")
            # Remove all scheduled tasks and show the main dialog again
            ;;
        "Disable/Enable Music")
            # Toggle music flag
            ;;
        "Exit")
            # Exit the application
            exit 0
            ;;
    esac
done