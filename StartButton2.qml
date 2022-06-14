import QtQuick 2.0

Item
{
    id: root

    property bool greenMode: true

    height: 200
    width: 200

    Rectangle
    {
        id: background
        color: "#222c32"
        radius: 50
        height: parent.height
        width: parent.width

        Rectangle
        {
            id: button
            anchors.centerIn: parent
            color: "#369452"
            radius: 25
            height: 140
            width: 140

            Image
            {
                anchors.centerIn: parent
                source: greenMode ? "icons/start-icon.png" : "icons/stop-icon.png"
            }
        }
    }

    states:
        [

        State
        {
            name: "redMode"
            when: greenMode === false

            PropertyChanges
            {
                target: button
                color: "#df0057"
                scale: 0.95
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
                easing.type: Easing.OutExpo
                duration: 500
                properties: "color,scale"
            }
        }
    ]
}
