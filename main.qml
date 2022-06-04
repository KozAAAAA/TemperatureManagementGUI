import QtQuick 2.6
import QtQuick.Window 2.6


Window {
    width: 1920
    height:1080
    visible: true
    visibility: "FullScreen"
    title: qsTr("Temperature Menagment")

    Rectangle
    {
        id: background
        anchors.fill: parent
        color: "#141a1e"
    }



    FontLoader {id: robotoRegular; source: "Roboto-Regular.ttf"}


    GridShowBlocks2
    {
        id: gridShowBlocks2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 50
        visible: false

        currentTime:   _cppBackend.timeOutput   //info z c++
        currentTemp:   _cppBackend.tempOutput   //info z c++
        currentLoop:   _cppBackend.loopOutput   //info z c++
        currentBlock:  _cppBackend.blockOutput  //info z c++
    }


    GridSetupBlocks2
    {
        id: gridSetupBlocks2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 50
    }


    LoopSpinBox2
    {
        id:loopSpinBox2

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 50
    }


    StartButton2
    {
        id:startButton2

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 50

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
                    gridSetupBlocks2.visible = true
                    gridShowBlocks2.visible = false
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
                    gridShowBlocks2.loops = loopSpinBox2.input

                    gridSetupBlocks2.visible = false
                    gridShowBlocks2.visible = true
                    startButton2.greenMode = false
                }
            }
        }
    }


    Connections
    {
        target: _cppBackend
        onCompletedTemperatureControl:
        {
            startButton2.greenMode = true
            gridShowBlocks2.loops = 0
            gridSetupBlocks2.visible = true
            gridShowBlocks2.visible = false
        }
        onHeatingIsOn:
        {
            gridShowBlocks2.heatingIsOn = true
        }
        onHeatingIsOff:
        {
            gridShowBlocks2.heatingIsOn = false
        }
    }


}


