import QtQuick 2.0


Item
{
    width: 88
    height: 50


    Rectangle
    {
        id: shorter
        width: 12
        height: parent.height
        color: "white"
    }
    Rectangle
    {
        id: longer
        width: parent.width
        height: 12
        color: "white"
        anchors.left: shorter.left
        anchors.bottom: shorter.bottom
    }
}
