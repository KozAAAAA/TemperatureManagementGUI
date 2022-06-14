import QtQuick 2.0

Item
{
    id: root

    property bool heating: false

    height: 240
    width: 240


    Rectangle
    {
        id: background
        anchors.fill: parent
        radius: 50
        color: "#222c32"
    }

    Rectangle
    {
        id: subbackground
        anchors.margins: 30
        anchors.fill: parent
        radius: 25
        color: "#364652"
    }

    Rectangle
    {
        anchors.centerIn: parent
        height: 120
        width: height
        radius: height/2
        color: heating ? "#df0057" : "#222c32"
    }
}
