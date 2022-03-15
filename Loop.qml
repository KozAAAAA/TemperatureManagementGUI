import QtQuick 2.0

Item
{
    height:30
    width:100

    Text
    {
        anchors.left: parent.left
        id: name
        text: "Ilość pętli: "
        font.pixelSize: input.height
    }

    Rectangle
    {
        height: parent.height
        width: 60
        border.color: "lightblue"
        color: "white"
        radius: 4
        smooth: true
        clip: true
        anchors.left: name.right

        TextInput
        {
            anchors.fill: parent
            id: input
            font.pixelSize: parent.height
        }
    }
}
