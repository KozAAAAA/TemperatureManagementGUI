import QtQuick 2.6
import QtQuick.Controls 2.0

Item
{
    property string name
    property string output

    height: textname.height + output.height + textname.anchors.topMargin
    width: output.width

    Text
    {
        id: output
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }

        text: parent.output
        font.pointSize: 60


    }

    Text
    {
        id: textname
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top:output.bottom
            topMargin: 5
        }

        text: parent.name
        font.pointSize: 27



    }
}
