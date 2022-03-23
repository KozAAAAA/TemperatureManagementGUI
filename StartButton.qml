import QtQuick 2.0

Item
{
    height: 150
    width:  650

    Rectangle
    {
        anchors.fill: parent

        radius: 40
        color: "lightgreen"
    }


    Text
    {
        anchors.centerIn: parent

        text: "Start"
        font.pointSize: 60


    }
}
