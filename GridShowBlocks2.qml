import QtQuick 2.0


Column
{
    id: root

    property int currentTemp
    property int currentTime
    property int currentLoop
    property int loops
    property int currentBlock
    property var setTemp

    property bool heatingIsOn: false

    spacing: 50
    Row
    {
        ShowBlockTemp2{output: currentTemp}
        spacing: 50
        ShowBlock2{name:"set to"; output: setTemp+"°" ;x: 800}
    }
    Row
    {
        ShowBlock2{name:"loop"; output: currentLoop+"/"+loops ;x: 800}
        spacing: 50
        ShowBlock2{name:"mode"; output: currentBlock+"/4" ;x: 800}
    }
    Row
    {
        ShowBlockHeating2{ heating: heatingIsOn }
        spacing: 50
        ShowBlockTime2{output: currentTime}
    }
}

