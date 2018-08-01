#!/bin/bash
#Launch extraction on

if [ $# < 1 ];then
    echo "Argument : project id"
    exit 0
else
    echo "id : $1"
    framerate=$(echo $(head -n 1 projects/$1/parameters) | cut -d'=' -f2 | cut -d' ' -f1)
    duration=$(echo $(head -n 1 projects/$1/parameters) | cut -d'=' -f3 | cut -d'>' -f1)
    rm -f projects/$1/video.xml

    #frame extraction
    ffmpeg -i projects/$1/video.* -r $framerate projects/$1/image_%010d.png
    #Face Detection
    ../dlib_face_detection_recognition_6 projects/$1 projects/$1/image*.png
    sed -i.BAK '1d' projects/$1/video.xml
    echo "Done"
fi
