#! /usr/bin/python3

import random
def tempSensor():
    return round(random.uniform(20.1, 27.4), 2)

f = open("../../test/tempSensor_sim.txt", "w")
f.write(str(tempSensor()))
f.close()
