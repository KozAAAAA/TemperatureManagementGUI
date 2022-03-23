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
        id: setupBlocks
        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
    }

    LoopBlock
    {
        id: loopblock
        anchors.right: parent.right
    }

    GridShowBlocks
    {
        id: showBlocks
        anchors
        {
            verticalCenter:parent.verticalCenter
        }

        currentTime:  0    //info z c++
        currentTemp:  0    //info z c++
        currentLoop:  0    //info z c++
        currentBlock: 0    //info z c++

        amountLoop: loopblock.inputLoop
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
            // onClicked - wysyła zmienne do c++ i restart
            //onClicked: showBlocks.currentTime = setupBlocks.timeInputOne
        }
    }




}
