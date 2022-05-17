import QtQuick 2.0



Item
{
    readonly property int inputTime: time.input
    readonly property int inputTemp: temp.input

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

}
