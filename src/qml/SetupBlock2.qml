import QtQuick 2.0


Item
{
    id: root

    readonly property int inputTime: toggleswitch.toggleOn ? time.input : 0
    readonly property int inputTemp: toggleswitch.toggleOn ? temp.input : 0
    property int blockNumber

    width: 760
    height: 465

    Rectangle
    {
        anchors.fill: parent
        radius: 50
        color: "#222c32"
    }

    Column
    {
        anchors.verticalCenter: toggleswitch.verticalCenter
        anchors.left: toggleswitch.right
        anchors.leftMargin: 30
        TempInputBox2{id:temp; maxNumber: 200; unit:"°C"; toggleState: toggleswitch.toggleOn}
        spacing: 30
        TimeInputBox2{id:time; maxNumber:999; unit:"h"; toggleState: toggleswitch.toggleOn}
    }

    Rectangle
    {
        visible: toggleswitch.toggleOn ? false : true
        anchors.fill: parent
        radius: 50
        opacity: 0.7
        color: "#141a1e"
    }


    ToggleSwitch2
    {
        id:toggleswitch
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 40
        blockNumber: root.blockNumber
    }

    states:
        [

        State
        {
            name: "redMode"
            when: toggleswitch.toggleOn === false

            PropertyChanges
            {
                target: root
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
                properties: "scale"
            }
        }
    ]

}
