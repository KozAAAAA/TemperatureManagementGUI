import QtQuick 2.0

Item
{
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
            anchors.centerIn: parent
            color: greenMode ? "#369452" : "#df0057"
            radius: 25
            height: 140
            width: 140

            Image
            {
                anchors.centerIn: parent
                source: greenMode ? "start-icon.png" : "stop-icon.png"
            }

        }
    }
}
