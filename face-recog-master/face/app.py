# USAGE
# python build_face_dataset.py --output/-o {NAME}

# import the necessary packages
import imutils
from imutils.video import VideoStream
import numpy as np
import pickle
import time
import cv2
import os
from flask import Flask, jsonify
app = Flask(__name__)
names = []
@app.route('/api')
def hello_world():
    names = []
    return test()

if __name__ == '__main__':
    app.run(host="0.0.0.0",port=5000)

def is_in_array(name):
  """Returns True if the given name is already in the array, False otherwise."""
  for existing_name in names:
    if existing_name == name:
      return True
  return False

def add_to_array(name):
  """Adds the given name to the array if it is not already in it."""
  if not is_in_array(name):
    names.append(name)
    print(name)


def test():
    try:
        # load OpenCV's Haar cascade for face detection from disk
        face_cascade = cv2.CascadeClassifier('cascades/haarcascade_frontalface_default.xml')
        # build the recognizer
        recognizer = cv2.face.LBPHFaceRecognizer_create()
        recognizer.read("./recognizers/face-trainer.yml")

        # build the labels
        labels = {"person_name": 1}
        with open("pickles/face-labels.pickle", 'rb') as f:
            og_labels = pickle.load(f)
            labels = {v: k for k, v in og_labels.items()}
        print("Known Faces: {}".format(labels))

        # Start the video stream
        print("[INFO] starting video stream...")
        vs = VideoStream(src=0).start()
        time.sleep(2.0)

        i = 0
        # loop over the frames from the video stream
        while i < 200:
            # grab the frame from the threaded video stream, clone it (just in case we want to write it to disk), and then resize the frame
            frame = vs.read()
            orig = frame.copy()
            frame = imutils.resize(frame, width=400)
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

            # detect faces in the grayscale frame
            faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))
            red_color = (53, 25, 224)  # BGR

            for (x, y, w, h) in faces:
                roi_gray = gray[y:y + h, x:x + w]  # (ycord_start, ycord_end)
                roi_color = frame[y:y + h, x:x + w]

                font = cv2.FONT_HERSHEY_SIMPLEX
                fontscale = 1
                red_color = (53, 25, 224)  # BGR
                white_color = (255, 255, 255)  # BGR
                stroke = 2
                end_cord_x = x + w
                end_cord_y = y + h

                # recognize?
                name = ""
                id_, conf = recognizer.predict(roi_gray)
                if conf >= 65:
                    name = labels[id_]
                    # get the width and height of the text box
                    (text_width, text_height) = cv2.getTextSize(name, font, fontscale, stroke)[0]
                    # set the text start position
                    text_offset_x = x + 10 + stroke
                    text_offset_y = y - 5 - stroke
                    # put the stuff on the frame
                    cv2.rectangle(frame, (x - stroke, y),
                                  (end_cord_x + stroke, end_cord_y - h - text_height - stroke - 20),
                                  red_color, cv2.FILLED)
                    cv2.putText(frame, name, (text_offset_x, text_offset_y - 5),
                                font, fontscale, white_color, stroke, cv2.LINE_AA)
                    cv2.rectangle(frame, (x, y), (end_cord_x, end_cord_y), red_color, stroke)
                    add_to_array(name)
            # show the output frame
            cv2.imshow("Recognize Faces", frame)

            i += 1
            # if the `q` key was pressed, break from the loop
            key = cv2.waitKey(1) & 0xFF
            if key == ord("q"):
                break

        # do a bit of cleanup
        print("[INFO] cleaning up...")
        cv2.destroyAllWindows()
        vs.stop()

        if not names:  # Check if the names array is empty
            return jsonify(message="The names array is empty")
        else:
            return jsonify(names=names)

    except Exception as e:
        return jsonify(message="An error occurred: {}".format(str(e)))