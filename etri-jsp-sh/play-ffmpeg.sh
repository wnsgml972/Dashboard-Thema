ffmpeg -i ftp://user:1@192.168.10.2/sample.mp4 -hls_allow_cache 0 -threads 8 -cpu-used 5 -deadline realtime -framerate 24 -an http://192.168.10.1:12390/feed1.ffm
