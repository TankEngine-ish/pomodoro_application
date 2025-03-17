#!/bin/bash

work_music_file="/home/plamen/Pomodoro_Application/assets/Stormwind.mp3"  # this is the path to your tune
break_music_file="/home/plamen/Pomodoro_Application/assets/Stormwind_2.mp3"  # and this is the path to your break tune

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

# this kill command finishes any running play commands when the script exits so you don't hear any music after the script is done
trap 'pkill -f "play -q $music_file"' EXIT

while true; do
    action=$(zenity --list --title="Pomodoro Timer" --column="Actions" "Start" "Exit")


    if [ $? -ne 0 ]; then
        exit 0
    fi

    case $action in
        "Start")
            (sleep 1500; play -q $work_music_file) &
            play_pid=$!  
            show_countdown 1500 "Time remaining"
            if [ $? -ne 0 ]; then  
                kill $play_pid  
                continue  
            fi
            zenity --info --text="Break time! Take a 5-minute break."
            (sleep 300; play -q $break_music_file) &
            play_pid=$!  
            show_countdown 300 "Break time remaining"
            if [ $? -ne 0 ]; then  
                kill $play_pid  
            fi
            ;;
        "Exit")
           
            exit 0
            ;;
    esac
done
