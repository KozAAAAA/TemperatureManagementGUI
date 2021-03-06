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
                setTemp: gridSetupBlocks2.tempArray[(_cppBackend.blockOutput)-1]  //info od setup
                loops: loopSpinBox2.input //info od setup
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
                    if(!transition.running)
                    {
                        // Stop clicked:
                        if(startButton2.greenMode === false)
                        {
                            _cppBackend.endTemperatureControl()
                        }
                        // Start clicked:
                        else if(loopSpinBox2.input !==0 && (
                                gridSetupBlocks2.timeArray[0] !==0 ||
                                gridSetupBlocks2.timeArray[1] !==0 ||
                                gridSetupBlocks2.timeArray[2] !==0 ||
                                gridSetupBlocks2.timeArray[3] !==0 ) )
                        {
                            startButton2.greenMode = false
                            for (var i = 0; i<4 ; i++)
                            {
                                _cppBackend.setInputParam("temp", gridSetupBlocks2.tempArray[i], i)
                                _cppBackend.setInputParam("time", gridSetupBlocks2.timeArray[i], i)
                            }
                            _cppBackend.setInputParam("loop", loopSpinBox2.input)
                            _cppBackend.printInputParam()
                            _cppBackend.startTemperatureControl()
                        }
                    }
                }
            }
        }

        states:State
        {
            name: "show"
            when: startButton2.greenMode === false
            AnchorChanges
            {
                target: columnSetupShow
                anchors.top: parent.top
                anchors.bottom: undefined
            }
            AnchorChanges
            {
                target: loopSpinBox2
                anchors.right: parent.left
                anchors.left: undefined
            }
        }
        transitions:Transition
        {
            id: transition
            from:"*" ; to: "*"
            AnchorAnimation
            {
                easing.type: Easing.InOutQuint
                duration: 2000
            }
        }
    }

    Connections
    {
        target: _cppBackend
        onCompletedTemperatureControl:
        {
            startButton2.greenMode = true
        }
        onHeatingIsOn:
        {
            gridShowBlocks2.heatingIsOn = true
        }
        onHeatingIsOff:
        {
            gridShowBlocks2.heatingIsOn = false
        }
        onErrorOutputChanged:
        {
            dialog.open();
        }
    }

    Dialog
    {
        id: dialog

        modal: true

        title: "Error: " + _cppBackend.errorOutput

        font.family: robotoRegular.name
        font.pointSize: 40

        x: (parent.width - width)/2
        y: (parent.height - height)/2

        Label
        {
            anchors.centerIn: parent
            text: "Mateusz Koza +48609453368"
        }
    }

}





