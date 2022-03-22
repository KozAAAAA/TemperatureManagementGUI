import QtQuick 2.6
import QtQuick.Controls 2.0

Rectangle
{

    property int input: 9
    property string unit: "unit"
    property string name: "Unknown"

    height: 300
    width: 300

    border.color: "red"
    border.width: 20


    Text
    {
        id: output
        anchors
        {
            horizontalCenter: parent.horizontalCenter

        }

        text: parent.input + " " + parent.unit
        font.pointSize: 60


    }

    Text
    {
        id: textname
        anchors {horizontalCenter: parent.horizontalCenter}

        text: parent.name
        font.pointSize: 27

        anchors.top: output.bottom

        anchors.topMargin: 5
    }
}
