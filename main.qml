import QtQuick 2.6
import QtQuick.Window 2.6



Window {
    width: 1920
    height:1080
    visible: true
    visibility: "FullScreen"
    title: qsTr("Hello World")

    Rectangle
    {
        color: "red"
        height: 50
        width: 50
        id:myButton
        MouseArea
        {
            anchors.fill: parent
            onClicked: loopclass.setSomeVar(setupBlocks.timeInputOne)
        }
    }

    TextInput
    {
        id:input
        text: "wprowadz tutaj"
        onEditingFinished: loopclass.setSomeVar(input.text)
    }

    Text
    {
        id: myLabel
        y:50
        text: loopclass.someVar
    }



















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
    }

    GridShowBlocks
    {
        id: show
        anchors
        {
            verticalCenter:parent.verticalCenter
        }
        currentTime:  _cppBackend.timeOutput    //info z c++
        currentTemp:  _cppBackend.tempOutput    //info z c++
        currentLoop:  _cppBackend.loopOutput    //info z c++
        currentBlock: _cppBackend.blockOutput    //info z c++

        amountLoop: loop.inputLoop
    }

    StartButton
    {
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
                for (var i = 0; i<4 ; i++)
                {
                    _cppBackend.setInputParam("temp", setup.tempArray[i], i)
                    _cppBackend.setInputParam("time", setup.timeArray[i], i)
                }
                _cppBackend.setInputParam("loop", loop.inputLoop)

                _cppBackend.printInputParam()
            }
            // onClicked - wysyła zmienne do c++ i restart
            //onClicked: showBlocks.currentTime = setupBlocks.timeInputOne
        }
    }




}
