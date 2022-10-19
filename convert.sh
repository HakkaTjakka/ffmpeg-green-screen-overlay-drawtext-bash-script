#!/bin/bash

FILENAME=$*
BASENAME="${FILENAME%.*}"

fold -sw 60 coverup_source.txt > coverup.txt

FONTNAME="BMWHelvetica-BlackCond"
FONTSIZE="44"
FONTSIZE2="34"
PARMS_IN="-y -hide_banner -nostdin"
COLOR="0xFFFFFF"
BACKGROUNDCOLOR="0x3030FF"
OUTLINE="3"
BORDERCOLOR="0x00008F"
SHADOWCOLOR="0x000050"

SPEED=2.0
RATE=$(ffprobe -v error -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "plane.mp4")
PITCH="1.00"

ffmpeg $PARMS_IN \
	-stream_loop -1 -i "plane.mp4" \
	-stream_loop -1 -i "green.mp4" \
	-filter_complex " \
	[0:a]asetrate=$RATE/$PITCH,aresample=44100,atempo=(1.0/($SPEED/$PITCH)),volume=0.8[a0];
	[1:a]aresample=44100,volume=2.0[a1];
	[0:v]setpts=$SPEED*PTS,fps=60,scale=1280x720, \
	drawtext=enable='gte(t,0)': \
	fontfile=$FONTNAME:fontsize=$FONTSIZE:fontcolor=$COLOR:bordercolor=$BORDERCOLOR:borderw=$OUTLINE: \
	shadowcolor=$SHADOWCOLOR:shadowx=5:shadowy=5: \
	textfile=coverup.txt:expansion=normal:reload=1: \
	y=h-line_h-t*30: \
	x=55[v0]; \
	[1:v]scale=1280x720,fps=60,colorkey=0x00ff00:0.4:0.2[ckout];[v0][ckout]overlay[v2]; \
	[v2]drawtext=enable='gte(t,0)': \
	fontfile=$FONTNAME:fontsize=$FONTSIZE2:fontcolor=$COLOR:bordercolor=$BORDERCOLOR:borderw=3: \
	shadowcolor=$SHADOWCOLOR:shadowx=5:shadowy=5: \
	text='Joseph Lee, MD  @leelasik':expansion=normal: \
	y=h-line_h-35: \
	x=w-450[v]; \
	[a0][a1]amix=inputs=2:duration=longest[a]
	" \
	-map "[v]" \
	-map "[a]" \
	-t 00:09:12 \
	-c:v h264_nvenc -pix_fmt yuv420p -preset slow \
	-b:v 2000k \
	output.mp4

#	change encoder h264_nvenc to libx264 if ness.

#	output_%03d.mp4
#	-map 1:a:0 \
#	-f segment -segment_time 137 -reset_timestamps 1 \
# 	ffmpeg -y -i output.mp4 -t 00:04:45 -c copy output2.mp4
#	-shortest
#	fontfile=$FONTNAME:fontsize=$FONTSIZE:fontcolor=$COLOR:bordercolor=$BORDERCOLOR:borderw=$OUTLINE: \
#	ffplay -f lavfi life=s=1000x1000:mold=10:r=60:ratio=0.1:death_color=#C83232:life_color=#ffffff,scale=1920x1080:flags=16
# 	Joseph Lee, MD
# 	@leelasik
#	-preset fast	
#	-t 139.9 -c:v h264_nvenc -pix_fmt yuv420p -preset fast output.mp4
#	y=h-line_h-100*t: \
#	ffmpeg -hide_banner -i "$FILENAME" -filter_complex "[0:v]crop=880:680:200:0,setpts=$SPEED*PTS,fps=fps=60,setsar=1/1[v];[0:a]asetrate=$RATE/$PITCH,aresample=44100,atempo=(1.0/($SPEED/$PITCH))[a]" -map "[v]" -map "[a]" -c:v h264_nvenc -pix_fmt yuv420p -preset slow -c:a aac -ac 2 -b:a 64k  -b:v 1000k "$BASENAME.TWITTER.MP4"
#	,crop=1280:400:0:200
#	ffmpeg -i "plane.mp4" -i green.mp4 -filter_complex \
#    '[1:v]colorkey=0x00ff00:0.4:0.2[ckout];[0:v][ckout]overlay[out]' \
#    -map '[out]'  -c:v libx264 -pix_fmt yuv420p res.mp4
#	y=h-line_h-60: \
#	x=-200*t" \
# 	fix_bounds:
# 	expansion=normal:
#	x=(W/tw)*n 
#	x=(W/tw)*n -t 5 output.mp4
#	y=h-line_h-120:x=-100*t:
#	FORCE_STYLE="'Fontname=$FONTNAME,FontSize=$FONTSIZE,Outline=$OUTLINE,PrimaryColour=&H$COLOR,OutlineColour=&H$OUTLINE_COLOR,BackColour=&H$BACK_COLOR,Shadow=$SHADOW,Angle=$ANGLE,BorderStyle=$BORDERSTYLE,Alignment=$ALIGNMENT'"
#	SUBTITLES="subtitles=f='$line':force_style=$FORCE_STYLE"
#	ffmpeg -i input -vf "drawtext=enable='gte(t,3)':fontfile=verdana.ttf:textfile=text.txt:reload=0:y=h-line_h-10:x=(W/tw)*n" output
#	ffmpeg -f lavfi -i "color=color=yellow, drawtext=enable='gte(t,0)':text=Text1 Text2 Text3 Text4 Text5 Text6 Text7 Text8 Text9 Text10:expansion=normal:fontfile=verdana.ttf: y=h-line_h-120:x=-100*t: fontcolor=white: fontsize=50" -t 20 Output.mp4fold -sw 60 coverup2.txt > coverup.txt
# 	fold -sw 60 coverup2.txt > coverup.txt

#	FILELENGTH=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$FILENAME")
#	RATE=$(ffprobe -v error -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "$FILENAME")
#	PITCH="1.00"
#	SPEED=$(echo "(139/$FILELENGTH)"| bc -l)
#	ffmpeg -hide_banner -i "$FILENAME" -filter_complex "[0:v]setpts=$SPEED*PTS,fps=fps=60[v];[0:a]asetrate=$RATE/$PITCH,aresample=44100,atempo=(1.0/($SPEED/$PITCH))[a]" -map "[v]" -map "[a]" -c:v h264_nvenc -pix_fmt yuv420p -preset slow -c:a aac -ac 2 -b:a 64k -b:v 500k "$BASENAME.TWITTER.MP4"

#	######## SPEED="140*$FILELENGTH"
#	######## SPEED="140/$FILELENGTH"
#	# SPEED=$(echo "(140/$FILELENGTH)"| bc -l)
#	######## SPEED=$(echo "(400/$FILELENGTH)"| bc -l)
#	#######
#	## echo $FILELENGTH 
#	## echo $FILENAME
#	## echo $BASENAME
#	## echo $RATE
#	## echo $SPEED
#	## echo $PITCH
#	# ffmpeg -hide_banner -i "$FILENAME" -filter_complex "[0:v]setpts=$SPEED*PTS[v];[0:a]asetrate=$RATE/$PITCH,aresample=44100,atempo=(1.0/($SPEED/$PITCH))[a]" -map "[v]" -map "[a]" -c:v h264_nvenc -pix_fmt yuv420p -preset slow -c:a aac -ac 2 -b:a 64k -b:v 500k "$BASENAME.TWITTER.MP4"
#	# ffmpeg -hide_banner -i "$FILENAME" -filter_complex "[0:v]setpts=$SPEED*PTS,fps=fps=50,scale=1280:720:force_original_aspect_ratio=increase[v];[0:a]asetrate=$RATE/$PITCH,aresample=44100,atempo=(1.0/($SPEED/$PITCH))[a]" -map "[v]" -map "[a]" -c:v h264_nvenc -pix_fmt yuv420p -preset slow -c:a aac -ac 2 -b:a 64k "$BASENAME.TWITTER.MP4"
#	# ffmpeg -hide_banner -i "$FILENAME" -filter_complex "[0:v]setpts=$SPEED*PTS,fps=fps=50,scale=1280:720:force_original_aspect_ratio=increase[v];[0:a]asetrate=$RATE/$PITCH,aresample=44100,atempo=(1.0/($SPEED/$PITCH))[a]" -map "[v]" -map "[a]" -c:v h264_nvenc -pix_fmt yuv420p -preset slow -c:a aac -ac 2 -b:a 64k -b:v 500k "$BASENAME.TWITTER.MP4"
#	# ffmpeg -hide_banner -i "$FILENAME" -filter_complex "[0:v]setpts=$SPEED*PTS[v];[0:a]asetrate=$RATE/$PITCH,aresample=44100,atempo=(1.0/($SPEED/$PITCH))[a]" -map "[v]" -map "[a]" -c:v h264_nvenc -pix_fmt yuv420p -preset slow -c:a aac -ac 2 -b:a 64k "$BASENAME.TWITTER.MP4"
