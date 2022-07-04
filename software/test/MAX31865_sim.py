#! /usr/bin/python3

import random
def tempSensor():
    return round(random.uniform(200.1, 270.4), 2)

f = open("../../test/tempSensor_sim.txt", "w")
f.write(str(tempSensor()))
f.close()
