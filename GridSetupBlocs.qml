import QtQuick 2.0


Grid {
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

    SetupBlock {id:setupBlockOne}
    SetupBlock {id:setupBlockTwo}
    SetupBlock {id:setupBlockThree}
    SetupBlock {id:setupBlockFour}
}
