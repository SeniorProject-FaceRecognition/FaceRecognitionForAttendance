import cv2

# Load the face cascade
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
# Create a VideoCapture object
cap = cv2.VideoCapture(0)

i=0
# Capture frames from the camera
while i < 10:
    # Capture the current frame
    ret, frame = cap.read()

    # Convert the frame to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the grayscale frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(40, 40))

    # If faces are found
    for (x, y, w, h) in faces:
        # Draw a rectangle around the face
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

        # Save the face image
        cv2.imwrite("" + str(i) + ".jpg", frame[y:y + h, x:x + w])
        i += 1

    # Display the frame
    cv2.imshow("Frame", frame)

    # Wait for a key press
    key = cv2.waitKey(1)

    # If the key `q` is pressed, break from the loop
    if key == ord("q"):
        break

# Release the capture object
cap.release()

# Close all windows
cv2.destroyAllWindows()