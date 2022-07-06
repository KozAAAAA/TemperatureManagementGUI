#! /usr/bin/python3

import random
import os

def tempSensor():
    return round(random.uniform(20.1, 27.4), 2)

f = open(os.path.abspath(os.path.dirname(__file__)) +"/tempSensor_sim.txt", "w") 
f.write(str(tempSensor()))
f.close()
