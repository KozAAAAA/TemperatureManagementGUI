import QtQuick 2.6
import QtQuick.Controls 2.0

Item
{
    id: root

    property int maxNumber
    property string unit
    property bool toggleState

    readonly property int input: control.value

    height: 178
    width: 494


    SpinBox
    {
        id: control
        height: parent.height
        width: parent.width
        smooth: true
        editable: false
        clip: true
        to: maxNumber * 100
        enabled: toggleState

        stepSize: 25

        property int decimals: 2
        property real realValue: value / 100

        validator: DoubleValidator {
            bottom: Math.min(control.from, control.to)
            top:  Math.max(control.from, control.to)
        }

        textFromValue: function(value, locale) {
            return Number(value / 100).toLocaleString(locale, 'f', control.decimals)
        }

        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text) * 100
        }


        background: Rectangle
        {
            id: background
            color: "#364652"
            radius: 25
            anchors.left: parent.left
            height: control.height
            width: 374
        }

        contentItem: Item{}
        TextInput
        {
            z:2
            text: control.textFromValue(control.value, control.locale) + unit
            font.family: robotoRegular.name
            font.pointSize: 82
            color:"white"
            readOnly: !control.editable
            validator: control.validator
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            horizontalAlignment: Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
            anchors.left: background.left
            anchors.verticalCenter: background.verticalCenter
            anchors.leftMargin: 15
        }

        up.indicator: Rectangle
        {
            anchors
            {
                top: parent.top
                right: parent.right
            }
            height: 178/2
            width:  90
            color: control.up.pressed ? "#556e81" : "#364652"
            radius: 25
            Rectangle
            {
                anchors.bottom: parent.bottom
                width: parent.width
                height: parent.radius
                color: parent.color
            }
            Rectangle
            {
                anchors.centerIn: parent
                color: "white"
                width: 44
                height: 8
            }
            Rectangle
            {
                anchors.centerIn: parent
                color: "white"
                width: 8
                height: 44
            }
        }

        down.indicator: Rectangle
        {
            anchors
            {
                bottom: parent.bottom
                right: parent.right
            }
            height: 178/2
            width:  90
            color: control.down.pressed ? "#556e81" : "#364652"
            radius: 25
            Rectangle
            {
                anchors.top: parent.top
                width: parent.width
                height: parent.radius
                color: parent.color
            }
            Rectangle
            {
                anchors.centerIn: parent
                color: "white"
                width: 44
                height: 8
            }
        }
    }
}
