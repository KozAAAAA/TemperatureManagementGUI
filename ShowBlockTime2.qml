import QtQuick 2.0


Item
{
    height: 240
    width: 1280
    property string output: "-5"

    property int currentTimeH: (output/(1000*60*60))
    property int currentTimeMin: (output/(1000*60)) %60
    property int currentTimeSec: (output/1000) %60

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
    text:
    {
        currentTimeH+":"+currentTimeMin+":"+currentTimeSec
    }
    font.family: robotoRegular.name
    font.pointSize: 130
    color:"white"
    }
}

