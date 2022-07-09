QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++17

SOURCES += \
        main.cpp \
        maingui.cpp \
        worker.cpp

RESOURCES += qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    maingui.h \
    settings.h \
    worker.h

PRECOMPILED_HEADER = pch.h

# RealayOn, RelayOff methods need it (Rpi only):
linux:contains(QMAKE_HOST.arch, armv7l):{
    LIBS += -lwiringPi -lstdc++fs
}

DISTFILES += \
    ../lib/MAX31865.py \
    ../lib/tempSensor.txt \
    ../test/MAX31865_sim.py \
    ../test/tempSensor_sim.txt \
    fonts/Roboto-Regular.ttf \
    icons/loop-icon.png \
    icons/start-icon.png \
    qml/GridSetupBlocks2.qml \
    qml/GridShowBlocks2.qml \
    qml/LoopSpinBox2.qml \
    qml/Ok.qml \
    qml/Plus.qml \
    qml/SetupBlock2.qml \
    qml/ShowBlock2.qml \
    qml/ShowBlockHeating2.qml \
    qml/ShowBlockTemp2.qml \
    qml/ShowBlockTime2.qml \
    qml/StartButton2.qml \
    qml/TempInputBox2.qml \
    qml/TimeInputBox2.qml \
    qml/ToggleSwitch2.qml \
    qml/fonts/Roboto-Regular.ttf \
    qml/icons/loop-icon.png \
    qml/icons/start-icon.png \
    qml/icons/stop-icon.png \
    qml/main.qml

