import QtQuick 2.0



Item
{
    readonly property int inputTime: toggleswitch.toggleOn ? time.input : 0
    readonly property int inputTemp: toggleswitch.toggleOn ? temp.input : 0

    width: 390
    height: 450

    Rectangle
    {
        anchors.fill: parent
        radius: 40
        color: "lightblue"
    }

    Column
    {
        anchors.centerIn: parent

        spacing: 20

        InputBox
        {
            id: temp
            name: "Temperatura (°C):"
            maxNumber: 200
        }

        InputBox
        {
            id: time
            name: "Czas (h):"
            maxNumber: 576
        }

    }

    Rectangle
    {
        color: "gray"
        opacity: toggleswitch.toggleOn ? 0 : 0.5
        anchors.fill: parent
    }

    ToggleSwitch
    {
        id: toggleswitch
        anchors.right: parent.right
        anchors.top: parent.top
    }




}
