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
        currentTime:  0    //info z c++
        currentTemp:  0    //info z c++
        currentLoop:  0    //info z c++
        currentBlock: 0    //info z c++

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
                _cppBackend.setInputParam("temp", setup.tempInputOne, 0)
                _cppBackend.setInputParam("temp", setup.tempInputTwo, 1)
                _cppBackend.setInputParam("temp", setup.tempInputThree, 2)
                _cppBackend.setInputParam("temp", setup.tempInputFour, 3)

                //showBlocks.currentTemp = _temperatureMenagment.getTemp(1)
            }
            // onClicked - wysyła zmienne do c++ i restart
            //onClicked: showBlocks.currentTime = setupBlocks.timeInputOne
        }
    }




}
