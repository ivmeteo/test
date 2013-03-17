echo "Set Frequency..." 
./v4l2-ctl --set-freq=77.25 -d /dev/video0 
echo "Set INPUT Id" 
./v4l2-ctl --set-input=0 -d /dev/video0 
echo "Set Norm" 
./v4l2-ctl -s secam-dk -d /dev/video0 
echo "Set INPUT Id" 
./v4l2-ctl --set-input=0 -d /dev/video1 
echo "Set Norm" 
./v4l2-ctl -s=secam-d -d /dev/video1 
echo "Start MPEG" 
echo "Configure MPEG stream" 
echo "Set Bitrate mode" 
./v4l2-ctl -c video_bitrate_mode=0 -d /dev/video1 
echo "Set audio sampling frequency" 
./v4l2-ctl -c audio_sampling_frequency=1 -d /dev/video1 
echo "Set audio encoding" 
./v4l2-ctl -c audio_encoding=1 -d /dev/video1 
echo "Set audio bitrate" 
./v4l2-ctl -c audio_layer_ii_bitrate=13 -d /dev/video1 
echo "Set video bitrate" 
./v4l2-ctl -c video_bitrate=7500000 -d /dev/video1 
./v4l2-ctl -c video_peak_bitrate=9500000 -d /dev/video1 
echo "Set aspect video" 
./v4l2-ctl -c video_aspect=1 -d /dev/video1 
