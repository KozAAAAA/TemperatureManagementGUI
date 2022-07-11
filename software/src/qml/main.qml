import QtQuick 2.6
import QtQuick.Window 2.6
import QtQuick.Controls 2.3


Window {

    id: mainWindow

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

    FontLoader {id: robotoRegular; source: "fonts/Roboto-Regular.ttf"}

    Item
    {
        id: root
        anchors.fill: parent

        Column
        {
            id: columnSetupShow

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 50

            GridShowBlocks2
            {
                id: gridShowBlocks2

                currentTime:   _cppBackend.timeOutput   //info z c++
                currentTemp:   _cppBackend.tempOutput   //info z c++
                currentLoop:   _cppBackend.loopOutput   //info z c++
                currentBlock:  _cppBackend.blockOutput  //info z c++
                setTemp:
                {
                    startButton2.greenMode ?
                                0 :
                                gridSetupBlocks2.tempArray[(_cppBackend.blockOutput)-1]  //info z c++
                }
            }

            spacing: 50

            GridSetupBlocks2
            {
                id: gridSetupBlocks2
                enabled: startButton2.greenMode
            }


        }

        LoopSpinBox2
        {
            id:loopSpinBox2
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 50
            enabled: startButton2.greenMode
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
                        startButton2.greenMode = true
                        _cppBackend.endTemperatureControl()
                        show.amountLoop = 0
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
                        startButton2.greenMode = false
                    }
                }
            }
        }




        states:
            [

            State{
                name: "show"
                when: startButton2.greenMode === false
                AnchorChanges {
                    target: columnSetupShow
                    anchors.top: parent.top
                    anchors.bottom: undefined
                }
                AnchorChanges {
                    target: loopSpinBox2
                    anchors.right: parent.left
                    anchors.left: undefined
                }
            }
        ]

        transitions:
            [
            Transition {
                from:"*" ; to: "*"

                AnchorAnimation{
                    easing.type: Easing.InOutQuint
                    duration: 2000
                }
            }
        ]
    }

    Connections
    {
        target: _cppBackend
        onCompletedTemperatureControl:
        {
            startButton2.greenMode = true
            gridShowBlocks2.loops = 0
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




