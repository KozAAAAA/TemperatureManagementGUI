import QtQuick 2.0

Item
{
    property bool toggleOn: false

    width: 50
    height: 50

    Rectangle
    {
        anchors.fill: parent
        color: toggleOn ? "green" : "red"
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: toggleOn = !toggleOn
    }

}

