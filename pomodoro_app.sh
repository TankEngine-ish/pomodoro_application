#!/bin/bash

# Initialize variables
work_music_file="/home/plamen/Pomodoro_Application/assets/Stormwind.mp3"  # Replace with the path to your music file
break_music_file="/home/plamen/Pomodoro_Application/assets/Stormwind_2.mp3"  # Replace with the path to your break music file
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
    return $?  
}

# Function to kill any running play commands when the script exits so you don't hear any music after the script is done
trap 'pkill -f "play -q $music_file"' EXIT

# Main loop
while true; do
    # Shows main dialog box
    action=$(zenity --list --title="Pomodoro Timer" --column="Actions" "Start" "Exit")

    # Check if the dialog was closed
    if [ $? -ne 0 ]; then
        exit 0
    fi

    case $action in
        "Start")
            # Schedule tasks
            (sleep 60; play -q $work_music_file) &
            play_pid=$!  # Save the PID of the play command
            show_countdown 60 "Time remaining"
            if [ $? -ne 0 ]; then  # If the countdown was cancelled
                kill $play_pid  # Kill the play command
                continue  # Skip the rest of the loop and return to the main dialog
            fi
            zenity --info --text="Break time! Take a 5-minute break."
            (sleep 60; play -q $break_music_file) &
            play_pid=$!  # Save the PID of the play command
            show_countdown 60 "Break time remaining"
            if [ $? -ne 0 ]; then  # If the countdown was cancelled
                kill $play_pid  # Kill the play command
            fi
            ;;
        "Exit")
            # Exit the application
            exit 0
            ;;
    esac
done