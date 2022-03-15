import QtQuick 2.6
import QtQuick.Window 2.6

Window {
    width: 1920
    height:1080
    visible: true
    //visibility: "FullScreen"
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
            onClicked: loopclass.setSomeVar("16")
        }
    }

    TextInput
    {
        id:input
        text: "wprowadz tutaj"
        onEditingFinished: loopclass.setSomeVar(input.text)
    }

    Text {
        id: myLabel
        y:50
        text: loopclass.someVar
    }

    Item
    {
        anchors.centerIn: parent

        TextBox
        {
            id: time1
            name: "Czas:"
        }

        TextBox
        {
            id: temp1
            name: "Temperatura:"
            anchors.top: time1.bottom
            anchors.topMargin: 20
        }
    }


    Text
    {
        text: time1.input
    }



}
