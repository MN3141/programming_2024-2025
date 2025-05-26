import tensorflow as tf
from keras.layers import Input,Dense,Flatten
from keras.models import Sequential
import matplotlib.pyplot as plt
from keras.datasets import mnist
import numpy as np

print("FOO")

#1
mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

#2
model = Sequential(
    [   Input((28,28)), 
        Flatten(),
        Dense(16, activation="relu", name="layer1"),
        Dense(16, activation="relu", name="layer2"),
        Dense(10, activation="softmax"),
    ]
) 
print("IT WORKS")

#3
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

model.fit(x_train, y_train, epochs=5, batch_size=32, validation_split=0.1)

test_loss, test_accuracy = model.evaluate(x_test, y_test)
print(test_accuracy)