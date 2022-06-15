import QtQuick 2.0

Item
{
    id: root

    property string output: "-5"

    height: 320
    width: 760

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

    Text
    {
        id: temp
        anchors.centerIn: parent
        text: output + "°"
        font.family: robotoRegular.name
        font.pointSize: 200
        color:"white"
    }


}
