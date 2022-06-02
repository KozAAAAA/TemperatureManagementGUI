import QtQuick 2.0

Item
{
    property bool toggleOn: false
    property int blockNumber: 0

    height: 385
    width: 155
    Rectangle
    {
        anchors.fill: parent
        color: toggleOn ? "#369452" : "#df0057"
        radius: 25

        Text
        {
            text: blockNumber
            font.family: robotoRegular.name
            font.pointSize: 82
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
        }

        Plus
        {
            id: nok
            visible: toggleOn ? false : true

            transform: Rotation{origin.x:nok.width/2; origin.y:nok.height/2; angle:45}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60

        }

        Ok
        {
            id: ok
            visible: toggleOn ? true : false

            transform: Rotation{origin.x:ok.width/2; origin.y:ok.height/2; angle:-45}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 94
        }

    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: toggleOn = !toggleOn
    }

}