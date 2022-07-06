#! /usr/bin/python3
import board
import digitalio
import adafruit_max31865
import os

def tempSensor():
	spi = board.SPI()
	cs = digitalio.DigitalInOut(board.D5)
	sensor = adafruit_max31865.MAX31865(spi, cs, wires=3)
	return sensor.temperature

f = open(os.path.abspath(os.path.dirname(__file__)) +"/tempSensor.txt", "w")
f.write(str(tempSensor()))
f.close()
