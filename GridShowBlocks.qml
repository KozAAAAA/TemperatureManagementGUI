import QtQuick 2.6


Grid {
    columns: 2
    spacing: 50

    property int currentTemp
    property int currentTime
    property int currentLoop
    property int currentBlock

    property int amountLoop


    ShowBlock {id: showBlockTemp;    name:"TEMP";    output: currentTemp;  unit:"°C"}
    ShowBlock {id: showBlockTime;    name:"CZAS";    output: currentTime;  unit:"h"}
    ShowBlock {id: showBlockLoop;    name:"PĘTLA";   output: currentLoop;   unit:"/"+amountLoop}
    ShowBlock {id: showBlockNumber;  name:"NASTAW";  output: currentBlock;  unit:"/4"}
}
