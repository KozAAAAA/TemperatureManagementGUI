#pragma once

#include <QObject>
#include <QtDebug>
#include <QThread>
#include <QFile>
#include <QElapsedTimer>
#include <QCoreApplication>

#include <iostream>
#include <array>
#include <filesystem>

#ifdef __arm__
    #include <wiringPi.h>
#endif
