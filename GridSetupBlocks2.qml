import QtQuick 2.0

Grid
{
    columns: 2
    spacing: 50

    readonly property variant timeArray:
    [
        setupBlockOne.inputTime,
        setupBlockTwo.inputTime,
        setupBlockThree.inputTime,
        setupBlockFour.inputTime,
    ]
    readonly property variant tempArray:
    [
        setupBlockOne.inputTemp,
        setupBlockTwo.inputTemp,
        setupBlockThree.inputTemp,
        setupBlockFour.inputTemp
    ]

    SetupBlock2 {id:setupBlockOne;   blockNumber:1}
    SetupBlock2 {id:setupBlockTwo;   blockNumber:2}
    SetupBlock2 {id:setupBlockThree; blockNumber:3}
    SetupBlock2 {id:setupBlockFour;  blockNumber:4}
}
