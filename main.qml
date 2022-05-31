import QtQuick 2.6
import QtQuick.Window 2.6


Window {
    width: 1920
    height:1080
    visible: true
    visibility: "FullScreen"
    title: qsTr("Temperature Menagment")

    FontLoader {id: robotoRegular; source: "Roboto-Regular.ttf"}



    GridSetupBlocs
    {
        id: setup
        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
    }

    LoopBlock
    {
        id: loop
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    GridShowBlocks
    {
        id: show
        anchors.verticalCenter:parent.verticalCenter
        currentTime:   _cppBackend.timeOutput   //info z c++
        currentTemp:   _cppBackend.tempOutput   //info z c++
        currentLoop:   _cppBackend.loopOutput   //info z c++
        currentBlock:  _cppBackend.blockOutput  //info z c++
    }

    StartButton
    {
        id: start
        anchors
        {
            left: parent.left
            bottom: parent.bottom
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                // Stop clicked:
                if(start.color == "red")
                {
                    _cppBackend.endTemperatureControl()
                    show.amountLoop = 0

                    start.color = "green"
                    start.text = "START"
                }

                // Start clicked:
                else if(loop.inputLoop !==0 &&
                        setup.timeArray[0] !==0 ||
                        setup.timeArray[1] !==0 ||
                        setup.timeArray[2] !==0 ||
                        setup.timeArray[3] !==0 )
                {
                    for (var i = 0; i<4 ; i++)
                    {
                        _cppBackend.setInputParam("temp", setup.tempArray[i], i)
                        _cppBackend.setInputParam("time", setup.timeArray[i], i)
                    }
                    _cppBackend.setInputParam("loop", loop.inputLoop)

                    _cppBackend.printInputParam()

                    _cppBackend.startTemperatureControl()
                    show.amountLoop = loop.inputLoop

                    start.color = "red"
                    start.text = "STOP"
                }
            }
        }

        Connections
        {
            target: _cppBackend
            onCompletedTemperatureControl:
            {
                start.color = "green"
                start.text = "START"
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

    SetupBlock2
    {
        x:20
        y:20

    }

}
