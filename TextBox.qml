import QtQuick 2.6



    Rectangle
    {

        property string name: "Unknown"
        readonly property string input: textinput.text

        height: textname.height + textrect.height + textrect.anchors.topMargin
        width: textrect.width

        Text
        {
            id: textname

            text: parent.name
            font.pointSize: 28
            anchors.left: parent.left
        }

        Rectangle
        {
            id: textrect

            anchors.top: textname.bottom
            anchors.left: textname.left
            anchors.topMargin: 10

            height: 67
            width: 290

            border.width: textinput.focus ? 6 : 2
            border.color: textinput.focus ? "lightblue" : "grey"

            color: "white"
            radius: 4
            smooth: true
            clip: true


            TextInput
            {
                id: textinput

                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.topMargin: 14
                font.pointSize: 28
                focus: true
                validator: IntValidator {bottom: 0; top: 999}
                onTextChanged: text > 200 ? text = "200" : text < 0 ? text = 0 : text = text


            }
        }
    }


