import QtQuick 2.6

Item
{
    property string name: "Unknown"
    property string output: "output"

    height: 300
    width: 300


    Rectangle
    {
        anchors.fill: parent

        radius: 40
        color: "violet"
    }

    OutputBox
    {
        name: parent.name
        output: parent.output

        anchors.centerIn: parent
    }
}
