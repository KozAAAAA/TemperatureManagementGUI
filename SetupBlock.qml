import QtQuick 2.0

Rectangle
{
    readonly property string timeInput: time.input
    readonly property string tempInput: temp.input

    width: 390
    height: 450
    radius: 40
    border.color: "lightblue"

    Column
    {
        anchors.centerIn: parent

        spacing: 20

        TextBox
        {
            id: temp
            name: "Temperatura (°C):"
        }

        TextBox
        {
            id: time
            name: "Czas (h):"
        }

    }
}
