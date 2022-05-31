import QtQuick 2.0

Item
{
    width: 88
    height: 88
    Rectangle
    {
        width: 12
        height: parent.height
        color: "white"
        anchors.centerIn: parent
    }
    Rectangle
    {
        width: parent.width
        height: 12
        color: "white"
        anchors.centerIn: parent
    }
}
