# ffmpeg -y -loop 1 -i "$1.jpg" -vf pad="width=ceil(iw/2)*2:height=ceil(ih/2)*2" -c:v libx264 -tune stillimage -pix_fmt yuv420p "$1.mp4"

ffmpeg -y -framerate 0.1 -loop 1 -i "Stan Rams.jpg" -i "leve-de-burgers-leve-de-republiek.mp3" -vf pad="width=ceil(iw/2)*2:height=ceil(ih/2)*2" -c:v h264_nvenc -pix_fmt yuv420p -bf:v 3 -preset slow -c:a copy -shortest "leve-de-burgers-leve-de-republiek.mp4"

#ffmpeg -framerate 1 -pattern_type glob -i '*.png' -c:v libx264 -r 30 -pix_fmt yuv420p out.mp4

#ffmpeg -framerate 30 -pattern_type glob -i '*.png' -i audio.ogg -c:a copy -shortest -c:v libx264 -pix_fmt yuv420p out.mp4
