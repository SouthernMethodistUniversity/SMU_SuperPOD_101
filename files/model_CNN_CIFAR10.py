import numpy as np
import pandas as pd
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.utils import to_categorical

from tensorflow.keras.layers import Conv2D # convolutional layers to reduce image size
from tensorflow.keras.layers import MaxPooling2D,AveragePooling2D  # Max pooling layers to further reduce image size
from tensorflow.keras.layers import Flatten # flatten data from 2D to column for Dense layer

# Load CIFAR10 data
from tensorflow.keras.datasets import cifar10
# load data
(X_train, y_train), (X_test, y_test) = cifar10.load_data()
# Normalized data to range (0, 1):
X_train, X_test = X_train/X_train.max(), X_test/X_test.max()

# OHE to convert label
num_categories = 10 # Ranges from 0-9
input_shape = (32,32,3) # 32 pixels with 3D color scale

y_train = tf.keras.utils.to_categorical(y_train,num_categories)
y_test = tf.keras.utils.to_categorical(y_test,num_categories)

# Construct CNN
model = Sequential()
model.add(Conv2D(8, (3, 3), strides=(1, 1), activation='relu', input_shape=input_shape))
model.add(MaxPooling2D(pool_size=(2, 2), strides=(2, 2)))

model.add(Flatten())
model.add(Dense(100, activation='relu'))
#Output layer contains 10 different number from 0-9
model.add(Dense(10, activation='softmax'))

# Compile model
model.compile(optimizer='adam', loss='categorical_crossentropy',  metrics=['accuracy'])                            
# Train model
history = model.fit(X_train, y_train, epochs=10, validation_data=(X_test, y_test))
model.save('model_cifar10')