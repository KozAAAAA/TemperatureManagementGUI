import QtQuick 2.6
import QtQuick.Controls 2.0

Item
{

    property int maxNumber: 99
    readonly property int input: control.value

    height: control.height
    width: control.width

    SpinBox
    {
        id: control
        height: 730
        width: 200
        smooth: true
        editable: false
        clip: true
        to: maxNumber
        enabled: true


        background: Rectangle
        {
            id: background
            color: "#222c32"
            radius: 50
            implicitHeight: 730
            implicitWidth: 200
        }

        contentItem: Item{} Rectangle
        {
            anchors.centerIn: background
            color: "#364652"
            radius: 25
            implicitHeight: 330
            implicitWidth: 140

            Image
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                source: "loop-image.png"
            }

            TextInput
            {
                id:text
                text: control.textFromValue(control.value, control.locale)
                font.family: robotoRegular.name
                font.pointSize: 82
                color:"white"
                readOnly: !control.editable
                validator: control.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
            }

        }


        up.indicator: Rectangle
        {
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            implicitHeight: 140
            implicitWidth:  140
            color: control.up.pressed ? "#556e81" : "#364652"
            radius: 25

            Rectangle
            {
                anchors.centerIn: parent
                color: "white"
                width: 88
                height: 12
            }
            Rectangle
            {
                anchors.centerIn: parent
                color: "white"
                width: 12
                height: 88
            }
        }

        down.indicator: Rectangle
        {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            implicitHeight: 140
            implicitWidth:  140
            color: control.down.pressed ? "#556e81" : "#364652"
            radius: 25


            Rectangle
            {
                anchors.centerIn: parent
                color: "white"
                width: 88
                height: 12
            }

        }
    }


}




