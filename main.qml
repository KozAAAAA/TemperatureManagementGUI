import QtQuick 2.6
import QtQuick.Window 2.6


Window {
    width: 1920
    height:1080
    visible: true
    visibility: "FullScreen"
    title: qsTr("Temperature Menagment")

    FontLoader {id: robotoRegular; source: "Roboto-Regular.ttf"}


    GridShowBlocks
    {
        id: show
        anchors.verticalCenter:parent.verticalCenter
        currentTime:   _cppBackend.timeOutput   //info z c++
        currentTemp:   _cppBackend.tempOutput   //info z c++
        currentLoop:   _cppBackend.loopOutput   //info z c++
        currentBlock:  _cppBackend.blockOutput  //info z c++
    }


    Column
    {
        spacing: 50

        StartButton2
        {
            id:startButton2
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    // Stop clicked:
                    if(startButton2.greenMode === false)
                    {
                        _cppBackend.endTemperatureControl()
                        show.amountLoop = 0
                        startButton2.greenMode = true
                    }

                    // Start clicked:
                    else if(loopSpinBox2.input !==0 &&
                            gridSetupBlocks2.timeArray[0] !==0 ||
                            gridSetupBlocks2.timeArray[1] !==0 ||
                            gridSetupBlocks2.timeArray[2] !==0 ||
                            gridSetupBlocks2.timeArray[3] !==0 )
                    {
                        for (var i = 0; i<4 ; i++)
                        {
                            _cppBackend.setInputParam("temp", gridSetupBlocks2.tempArray[i], i)
                            _cppBackend.setInputParam("time", gridSetupBlocks2.timeArray[i], i)
                        }
                        _cppBackend.setInputParam("loop", loopSpinBox2.input)

                        _cppBackend.printInputParam()

                        _cppBackend.startTemperatureControl()
                        show.amountLoop = loopSpinBox2.input

                        startButton2.greenMode = false
                    }
                }
            }
        }

        LoopSpinBox2
        {
            id:loopSpinBox2
        }
    }

    GridSetupBlocks2
    {
        id: gridSetupBlocks2
        x: 250
    }


    Connections
    {
        target: _cppBackend
        onCompletedTemperatureControl:
        {
            startButton2.greenMode = true
            show.amountLoop = 0
        }
        onHeatingIsOn:
        {
            show.heatingIsOn = true
        }
        onHeatingIsOff:
        {
            show.heatingIsOn = false
        }
    }
}

