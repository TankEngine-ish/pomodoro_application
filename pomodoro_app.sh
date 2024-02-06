#!/bin/bash

# Check if Zenity and at are installed
if ! command -v zenity &> /dev/null || ! command -v at &> /dev/null; then
    echo "Zenity and at are required but not installed. Please install them and try again."
    exit 1
fi


music_enabled=true
music_file="/home/plamen/Pomodoro_Application/assets/Stormwind.mp3"

# Function to remove all scheduled tasks
remove_tasks() {
    for job in $(atq | awk '{print $1}'); do
        atrm "$job"
    done
}
 

# Main loop
while true; do
    # Show main dialog
    action=$(zenity --list --title="Pomodoro Timer" --column="Actions" "Start" "Stop/Pause" "Reset" "Skip Break" "Disable/Enable Music" "Exit")

    case $action in
        "Start")
            # Schedule tasks
            if $music_enabled; then
                echo "play -q $music_file" | at now + 24 minutes 40 seconds
            fi
            echo 'zenity --info --text="Time for a break!"' | at now + 25 minutes
            ;;
        "Stop/Pause"|"Reset"|"Skip Break")
            # Remove all scheduled tasks
            remove_tasks
            ;;
        "Disable/Enable Music")
            # Toggle music flag
            music_enabled=!$music_enabled
            ;;
        "Exit")
            # Exit the application
            exit 0
            ;;
    esac
done