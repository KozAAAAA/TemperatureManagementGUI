import QtQuick 2.0

Item
{
    height: 320
    width: 760
    property string name: "name"
    property string output: "-5"
    Rectangle
    {
        id: background
        anchors.fill: parent
        radius: 50
        color: "#222c32"
    }

    Rectangle
    {
        id: subbackgound
        anchors.topMargin: (parent.height/2)
        anchors.margins: 30
        anchors.fill: parent
        radius: 25
        color: "#364652"
    }

    Text
    {
        id: myname

        text: name
        font.family: robotoRegular.name
        font.pointSize: 82
        color:"white"

        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter

    }

    Text
    {
        id: myvalue

        text: output
        font.family: robotoRegular.name
        font.pointSize: 82
        color:"white"

        anchors.centerIn: subbackgound

    }



}
