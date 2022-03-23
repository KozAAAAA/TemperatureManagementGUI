import QtQuick 2.6

Item
{
    property string name: "Unknown"
    property int output: 99
    property string unit: "unit"

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
        unit: parent.unit

        anchors.centerIn: parent
    }
}
