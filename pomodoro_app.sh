#!/bin/bash

# Initialize variables
music_file="/home/plamen/Pomodoro_Application/assets/Stormwind.mp3"  # Replace with the path to your music file

# Function to show a countdown timer
show_countdown() {
    local duration=$1
    local text=$2
    (
    for ((i=duration; i>0; i--)); do
        echo $((100*(duration-i)/duration))
        echo "# $text: $(printf "%02d:%02d" $((i/60)) $((i%60)))"
        sleep 1
    done
    echo 100
    ) | zenity --progress --auto-close
}

# Function to kill any running play commands when the script exits so you don't hear any music after the script is done
trap 'pkill -f "play -q $music_file"' EXIT

# Main loop
while true; do
    # Show main dialog
    action=$(zenity --list --title="Pomodoro Timer" --column="Actions" "Start" "Exit")

    # Check if the dialog was closed
    if [ $? -ne 0 ]; then
        exit 0
    fi

    case $action in
        "Start")
            # Schedule tasks
            (sleep 40; play -q $music_file fade 5) &
            show_countdown 60 "Time remaining"
            zenity --info --text="Break time! Take a 5-minute break."
            show_countdown 300 "Break time remaining"
            ;;
        "Exit")
            # Exit the application
            exit 0
            ;;
    esac
done