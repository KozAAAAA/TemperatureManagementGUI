import QtQuick 2.0

Item
{
    height: 150
    width:  650
    property string text: "START"
    property string color: "green"

    Rectangle
    {
        anchors.fill: parent

        radius: 40
        color: parent.color
    }

    Text
    {
        anchors.centerIn: parent

        text: parent.text
        font.pointSize: 60


    }
}
