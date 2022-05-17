import QtQuick 2.6


Grid {
    columns: 2
    spacing: 50

    property int currentTemp

    property int currentTime

    property int currentTimeH: (currentTime/(1000*60*60))
    property int currentTimeMin: (currentTime/(1000*60)) %60
    property int currentTimeSec: (currentTime/1000) %60

    property int currentLoop
    property int amountLoop

    property int currentBlock




    ShowBlock {id: showBlockTemp;    name:"TEMP";   output:currentTemp + "°C"}
    ShowBlock {id: showBlockTime;    name:"CZAS";   output:currentTimeH+":"+currentTimeMin+":"+currentTimeSec}
    ShowBlock {id: showBlockLoop;    name:"PĘTLA";  output:currentLoop+"/"+amountLoop}
    ShowBlock {id: showBlockNumber;  name:"NASTAW"; output:currentBlock+"/4"}
}



