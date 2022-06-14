import QtQuick 2.0

Item
{
    id: root

    property bool heating: false

    height: 240
    width: 240


    Rectangle
    {
        id: background
        anchors.fill: parent
        radius: 50
        color: "#222c32"
    }

    Rectangle
    {
        id: subbackground
        anchors.margins: 30
        anchors.fill: parent
        radius: 25
        color: "#364652"
    }

    Rectangle
    {
        id: roundrectangle
        anchors.centerIn: parent
        height: 120
        width: height
        radius: height/2
        color: "#222c32"
    }

    Rectangle
    {
        id: roundrectangle2
        anchors.centerIn: parent
        height: 120
        width: height
        radius: height/2
        color: "#df0057"
        scale: 0
    }

    states:
        [

        State
        {
            name: "heating"
            when: heating == true

            PropertyChanges
            {
                target: roundrectangle2
                color: "#df0057"
                scale: 1
            }
        }
    ]

    transitions:
        [
        Transition
        {
            from:"*" ; to: "*"

            PropertyAnimation
            {
                easing.type: Easing.OutInQuint
                duration: 1000
                properties: "scale"
            }
        }
    ]

}
