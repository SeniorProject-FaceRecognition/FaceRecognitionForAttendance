# USAGE
# python build_face_dataset.py --output/-o {NAME}

# import the necessary packages
from imutils.video import VideoStream
import argparse
import imutils
import time
import cv2
import os

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-o", "--output", required=True,
	help="Please pass -o or --output to help label the face")
args = vars(ap.parse_args())

# load OpenCV's Haar cascade for face detection from disk
face_cascade = cv2.CascadeClassifier('cascades/haarcascade_frontalface_default.xml')
# Generate the new file name
total = 0
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LABEL_DIR = "images/"+args["output"]
image_dir = os.path.join(BASE_DIR, LABEL_DIR)
images = []
print(args["output"])
for root, dirs, files in os.walk(image_dir):
	for file in files:
		if ".png" in file:
			num = int(file.replace(".png",""))
			images.append	
# last_index = max(images)
# total = last_index + 1 

# Start the video stream
print("[INFO] starting video stream...")
vs = VideoStream(src=0).start()
time.sleep(2.0)

# loop over the frames from the video stream
while True:
	# grab the frame from the threaded video stream, clone it (just in case we want to write it to disk), and then resize the frame
	frame = vs.read()
	orig = frame.copy()
	frame = imutils.resize(frame, width=400)

	# detect faces in the grayscale frame
	rects = face_cascade.detectMultiScale(cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY), scaleFactor=1.1,minNeighbors=5, minSize=(30, 30))
	red_color = (53, 25, 224) #BGR
	
	# loop over the face detections and draw them on the frame
	for (x, y, w, h) in rects:
		cv2.rectangle(frame, (x, y), (x + w, y + h), red_color, 2)

	# show the output frame
	cv2.imshow("Gather Faces", frame)
	key = cv2.waitKey(1) & 0xFF
 
	# if the `k` key was pressed, write the *original* frame to disk
	# so we can later process it and use it for face recognition
	if key == ord("k"):
		p = os.path.sep.join([image_dir, "{}.png".format(str(total))])
		cv2.imwrite(p, orig)
		print("Saved {}.png".format(total))
		total += 1

	# if the `q` key was pressed, break from the loop
	elif key == ord("q"):
		break

# do a bit of cleanup
print("[INFO] {} face are now stored".format(total))
print("[INFO] cleaning up...")
cv2.destroyAllWindows()
vs.stop()