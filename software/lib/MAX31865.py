#! /usr/bin/python3

import random
def tempSensor():
    return round(random.uniform(20.1, 27.4), 2)

f = open("../../lib/tempSensor.txt", "w")
f.write(str(tempSensor()))
f.close()
