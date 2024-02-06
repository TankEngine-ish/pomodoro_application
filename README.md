# Pomodoro_Application
Unix-based Pomodoro in Bash + Zenity


sox package
libsox-fmt-mp3
zenity + at


interesting error I enountered was this 
zenity: symbol lookup error: /snap/core20/current/lib/x86_64-linux-gnu/libpthread.so.0: undefined symbol: __libc_pthread_init, version GLIBC_PRIVATE

which I fixed by running my script in the terminal instead of the vscode environment.