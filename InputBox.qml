import QtQuick 2.6
import QtQuick.Controls 2.0

Item
{

    property string name: "Unknown"
    property int maxNumber: 0
    readonly property int input: input.value

    height: textname.height + input.height + input.anchors.topMargin
    width: input.width

    Text
    {
        id: textname
        anchors {left: parent.left}

        text: parent.name
        font.pointSize: 27
    }

    SpinBox
    {
        id: input
        anchors {top: textname.bottom ; left: textname.left ; topMargin: 10}

        height: 67
        width: 290

        smooth: true
        font.pointSize: 27
        editable: true
        clip: true

        to: maxNumber
    }
}
