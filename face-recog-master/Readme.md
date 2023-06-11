# Machine Learning Face Recognition

### What is this?
This awesome scripts allows you to do the most annoying tasks of building a machine learning model for facial recognition. Gathering your images for training, doing the training, the detection of faces, and then obviously the recognition itself.

##### IMPORTANT
These python script use **Python v3.7.2** and assumes you have a basic understanding of **pip** and **virtualenv** for package management and module installation. 
> If you want to learn how to setup python and virtual environments please click here:
> https://docs.python-guide.org/starting/installation/

## Files

**/face/...**: The main folder of the scripts: gather.py, train.py, and recognize.py

**/face/pickles/...:** your pickles aka labels will contain a file named: face-labels.pickle
  
**/face/recognizers/...:** your recognized model saved as face-trainer.yml

**/face/cascades/...:** contains all the haar cascade files

**/face/images/.../...:** Where all your image files save to when running gather.py


## Installation and Explanation 

Either bring it down with git or download the zip and create your virtualenv
Make sure to install all the imports (in a terminal):

`(ve) me @ ~/path/to/face]: pip install opencv-contrib-python`

`(ve) me @ ~/path/to/face]: pip install imutils`

`(ve) me @ ~/path/to/face]: pip install pillow`

`(ve) me @ ~/path/to/face]: pip3 install numpy`

Once installing those pesky modules this is a pretty simple model to build then use. 

# 1. Generate pictures and label them
### Running gather.py
Normally this process sucks...however, this is pretty easy to do with this script. Simply run the following command in a terminal on a computer with at least one camera on it. Obviously, make sure you are at the path of the directory where this project downloaded/unzipped to (also that you have activated the virtualenv): 

`(ve) me @ ~/path/to/face]: python gather.py -o your_name`

or 

`(ve) me @ ~/path/to/face]: python gather.py --output your_name`

Once it finds the camera it will boot up a new window with the frame of what the camera sees. Then once it detects a face in the frame the red rectangle will wrap the frame of the face detected.

> **Pressing the 'K' key** will capture and save the new images to the folder name whatever your pass in the -o parameter. Boom! As simple as that! You should collect somewhere between 10-100 images for each face you want to train. 

> **Pressing the 'Q' key** will quit running the process at anytime.

Just make sure that you restart this for each unique face you want to train your model upon, example:

`(ve) me @ ~/path/to/face]: python gather.py -o other_name`

or 

`(ve) me @ ~/path/to/face]: python gather.py --output other_name`

# 2. Train your Model
### Running train.py
Okay, so we have a bunch of images, but now we need to train our model on the content of the images in our folders. We do this using the awesome capabilities of OpenCV and the ability to read Haar Cascade files (explained nicely here: http://www.willberger.org/cascade-haar-explained/). Obviously, make sure you are at the path of the directory where this project downloaded/unzipped to (also that you have activated the virtualenv): 

`(ve) me @ ~/path/to/face]: python train.py`

##### Example Result: `{'your_name':0,'other_name':1}`

> Anytime you add new images to the **images/your_name** or **images/other_name** directory or whatever you name them, you should retrain your model. Just run the same command again...

# 3. Detect and Recognize
### Running recognize.py
Last step! Now that we have trained our model we just need to run the script to use the camera to detect faces and see if recognize them with a certain confidence. (Default confidence range is if confidence >= 65%) feel free to change it depending on your lighting and camera resolution. Simply run the following command:

`(ve) me @ ~/path/to/face]: python train.py`

`Known Faces: {0: 'drew', 1: 'katie'}`

`[INFO] starting video stream...`

![Sample](https://i.imgur.com/3BvZ4iF.jpg)

# FAQ

1. **What is this?** It's a tool I built to detect, train, and recognize faces

2. **How does it work?** It uses python, openCV, and some other cool stuff to make this process really simple!

3. **Why share this for free?** Because it took me forever to do this, I thought I would share it with others so if someone is 
lookin to do this on their own this is a great starting point to the world of complexity that is Machine Learning face recognition and detection. **#OpenSource4Lyfe**

4. **Can you help?** Sure, if you need help just send me a message on GitHub or on send me a DM on Twitter: [@That_Drew_Guy](http://twitter.com/That_Drew_Guy)
