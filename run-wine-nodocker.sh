#!/usr/bin/env bash
Xvfb :99 -screen 0 800x600x16 < /dev/null > /dev/null 2>&1 &
x86_64-w64-mingw32-g++ ./winvm/sendkey.cpp -o ~/.wine/drive_c/synckey.exe -lws2_32 -static-libgcc -static-libstdc++
ffmpeg -r 10 -f x11grab -draw_mouse 0 -s 800x600 -i :99 -c:v libvpx -quality realtime -cpu-used 0 -b:v 384k -qmin 10 -qmax 42 -maxrate 384k -bufsize 1000k -an -f rtp rtp:/127.0.0.1:5004 < /dev/null > /dev/null 2>&1 & 
wine C:\\synckey.exe $3 $4 < /dev/null > /dev/null 2>&1 & 
cd $1
DISPLAY=:99 wine $2 -w < /dev/null > /dev/null 2>&1 &
