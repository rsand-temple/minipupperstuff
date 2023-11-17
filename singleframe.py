import cv2
import time

cam=cv2.VideoCapture(2)

_,frame = cam.read()
timestr = time.strftime("%Y%m%d-%H%M%S")
cv2.imwrite("/home/ubuntu/docs/unknown/frame%s.jpg" % timestr, frame )

cam.release()
