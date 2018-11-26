#!/bin/bash -x
ffmpeg -i $uploadfile ${uploadfile%.avi}.webm;
rm $uploadfile;
