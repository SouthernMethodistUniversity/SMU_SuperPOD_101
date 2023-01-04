---
title: "Sample Applications of MultiGPUs for Computer Vision using Horovod"
teaching: 20
exercises: 0
questions:
- "How to utilize MultiGPUs in SuperPOD"
objectives:
- "Apply Horovod to drive multiple GPUs using CIFAR100"
keypoints:
- "NGC Container, Horovod, Computer Vision"
---

# MultiGPUs using CIFAR100

- In the code, Horovod is imported for MultiGPUs generation
- Rest of the code are regular computer vision model as seen in many other papers


Here is the sample python code that utilizing Tensorflow to train the CIFAR100 datasets;

```python
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, BatchNormalization, Dropout
from tensorflow.keras.utils import to_categorical

from tensorflow.keras.layers import Conv2D # convolutional layers to reduce image size
from tensorflow.keras.layers import MaxPooling2D,AveragePooling2D # Max pooling layers to further reduce image size   
from tensorflow.keras.layers import Flatten # flatten data from 2D to column for Dense layer

from tensorflow.keras.datasets import cifar100
import matplotlib.pyplot as plt
# TODO: Step 1: import Horovod
import horovod.tensorflow.keras as hvd
# TODO: Step 1: initialize Horovod
hvd.init()

# TODO: Step 1: pin to a GPU
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    tf.config.experimental.set_memory_growth(gpus[hvd.local_rank()], True)
    tf.config.experimental.set_visible_devices(gpus[hvd.local_rank()], 'GPU')


def plot_acc_loss(history):
    plt.plot(history.history['accuracy'])
    plt.plot(history.history['val_accuracy'])
    plt.title('model accuracy')
    plt.ylabel('accuracy')
    plt.xlabel('epoch')
    plt.legend(['training', 'validation'], loc='best')
    plt.savefig("calval_hvod.png") #save as jpg
    plt.show()

# load data
(X_train, y_train), (X_test, y_test) = cifar100.load_data()

# Normalized data to range (0, 1):
X_train, X_test = X_train/X_train.max(), X_test/X_test.max()

num_categories=100
y_train = tf.keras.utils.to_categorical(y_train,num_categories)
y_test = tf.keras.utils.to_categorical(y_test,num_categories)

model = Sequential()
model.add(Conv2D(1024, (3, 3), strides=(1, 1), activation='relu', input_shape=(32, 32, 3)))
model.add(MaxPooling2D(pool_size=(2, 2), strides=(2, 2)))
model.add(BatchNormalization())
model.add(Dropout(.1))
model.add(Conv2D(512, (3, 3), strides=(1, 1), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2), strides=(2, 2)))
model.add(BatchNormalization())
model.add(Dropout(.1))
model.add(Conv2D(256, (3, 3), strides=(1, 1), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2), strides=(2, 2)))
model.add(BatchNormalization())
model.add(Dropout(.1))

model.add(Flatten())
model.add(Dense(256, activation='relu'))
model.add(BatchNormalization())
model.add(Dropout(.1))

#Output layer contains 10 different number from 0-9
model.add(Dense(100, activation='softmax'))

model.summary()
# create model
model.compile(optimizer='Adam', loss='categorical_crossentropy',  metrics=['accuracy'])

#Train the model
model_CNN = model.fit(X_train, y_train, epochs=40,verbose=1,
                    validation_data=(X_test, y_test))

plot_acc_loss(model_CNN)
```

## Using SuperPOD to run MultiGPUs

The following batch script is used to submit the training job using 8 GPUs and Tensorflow 22.02 version

```
#!/bin/bash
#SBATCH -J CIFAR100M      # job name to display in squeue
#SBATCH -c 16 --mem=750G      # requested partition
#SBATCH -o output-%j.txt    # standard output file
#SBATCH -e error-%j.txt     # standard error file
#SBATCH --gres=gpu:8
#SBATCH -t 1440              # maximum runtime in minutes
#SBATCH -D /work/users/tuev/cv1/cifar100/multi
#SBATCH --exclusive
#SBATCH --mail-user tuev@smu.edu
#SBATCH --mail-type=end

srun --container-image=$WORK/sqsh/nvidia+tensorflow+22.02-tf2-py3.sqsh --container-mounts=$WORK mpirun -np 8 --allow-run-as-root --oversubscribe python /work/users/tuev/cv1/cifar100/multi/cifar100spod-hvod.py
```
