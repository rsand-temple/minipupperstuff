import face_recognition
import cv2
import os
import pickle

font = cv2.FONT_HERSHEY_SIMPLEX
encodings = []
names = []

dir_known = '/home/ubuntu/docs/faces'

# Load training data
for root, dirs, files in os.walk(dir_known):
    for file in files:
        path = os.path.join(root, file)
        name = os.path.splitext(file)[0]

        print('Encoding', name)

        person = face_recognition.load_image_file(path)
        findings = face_recognition.face_encodings(person)
        if len(findings) > 0:
            encoding = findings[0]
            encodings.append(encoding)
            names.append(name)
        else:
            print('WARNING: could not find any faces in', file)

# Pickle
print('Writing /home/ubuntu/docs/train.pkl')
with open('/home/ubuntu/docs/train.pkl', 'wb') as tdf:
    pickle.dump(names, tdf)
    pickle.dump(encodings, tdf)

