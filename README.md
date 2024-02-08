# Pomodoro_Application

This repository contains a simple Pomodoro timer implemented as a Bash script. The script uses Zenity for GUI dialogs and SoX to play an audio file when the work timer ends. Why did I decide to do that? I don't know.

## Dependencies
The script has the following dependencies:

Bash,
Zenity,
SoX (for the play command).
On a Debian-based Linux distribution, you can install these dependencies with the following command:

```
sudo apt-get install zenity sox
```

## Usage
To use the script, first make it executable with the following command:

```
chmod +x /path/to/pomodoro.sh
```

Then you can run the script with:

```
./path/to/pomodoro.sh
```

The script will display a dialog with two options: "Start" and "Exit". If you choose "Start", it will start a 25-minute work timer. When the work timer ends, it will play an audio file and start a 5-minute break timer.

You can cancel the work timer at any time by closing the progress dialog. If you do this, the audio file will not play and the break timer will not start.

## Customization
You can customize the script by editing the following variables at the top of the script:

work_music_file & break_music_file: The paths to the audio files that will be played when the work timer and the break timer end. This should be a file in a format that SoX can play (such as .mp3 or .wav). In my case it's a short soundtrack from a very early expansion of World of Warcraft.

work_duration: The length of the work timer, in seconds. The default is 1500 seconds (25 minutes).

break_duration: The length of the break timer, in seconds. The default is 300 seconds (5 minutes).