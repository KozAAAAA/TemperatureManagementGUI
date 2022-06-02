import QtQuick 2.0


Item
{
    readonly property int inputTime: toggleswitch.toggleOn ? time.input : 0
    readonly property int inputTemp: toggleswitch.toggleOn ? temp.input : 0

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
        InputBox2{id:temp; maxNumber: 200; unit:"°C"; toggleState: toggleswitch.toggleOn}
        spacing: 30
        InputBox2{id:time; maxNumber:999; unit:"h"; toggleState: toggleswitch.toggleOn}
    }

    Rectangle
    {
        visible: toggleswitch.toggleOn ? false : true
        anchors.fill: parent
        radius: 50
        opacity: 0.5
        color: "black"
    }


    ToggleSwitch2
    {
        id:toggleswitch
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 40
    }

}
