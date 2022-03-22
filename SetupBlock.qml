import QtQuick 2.0



Item
{
    readonly property int timeInput: time.input
    readonly property int tempInput: temp.input

    width: 390
    height: 450

    Rectangle
    {
        anchors.fill: parent
        radius: 40
        color: "lightblue"
        border.color: "darkblue"
        border.width: 4
        opacity: 0.4
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
            maxNumber: 999
        }

    }

}
