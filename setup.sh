#!/bin/sh
# Clone demo repo and install Jupyter
sudo pip3 install pillow lxml jupyter matplotlib cython
git clone https://github.com/rsand-temple/minipupperstuff
cp -pR minipupperstuff/* .
sudo cp /home/ubuntu/jupyter.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable jupyter.service
sudo systemctl start jupyter

# Face Recognition setup
sudo apt-get --assume-yes install libopenblas-dev liblapack-dev libjpeg-dev v4l-utils unzip
unzip faces.zip
pip3 install dlib
pip3 install face_recognition
mkdir docs
python train.py

# Object Detection setup
pip3 install tensorflow tflite-runtime
sudo apt-get --assume-yes install protobuf-compiler
mkdir tensorflow1
cd tensorflow1/
git clone --depth 1 https://github.com/tensorflow/models.git
echo export PYTHONPATH=/opt/ros/humble/lib/python3.10/site-packages:/opt/ros/humble/local/lib/python3.10/dist-packages:/home/ubuntu/tensorflow1/models/research:/home/ubuntu/tensorflow1/models/research/slim:~/tensorflow1/models/research:~/tensorflow1/models/research/slim >> ~/.bashrc
cd /home/ubuntu/tensorflow1/models/research/
protoc object_detection/protos/*.proto --python_out=.
mkdir coco_ssd_mobilenet_v1_1.0_quant_2018_06_29
cd coco_ssd_mobilenet_v1_1.0_quant_2018_06_29/
wget http://storage.googleapis.com/download.tensorflow.org/models/tflite/coco_ssd_mobilenet_v1_1.0_quant_2018_06_29.zip
unzip coco_ssd_mobilenet_v1_1.0_quant_2018_06_29.zip
