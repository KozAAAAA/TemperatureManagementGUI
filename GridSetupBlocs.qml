import QtQuick 2.0


Grid {
    columns: 2
    spacing: 50

    readonly property int timeInputOne:     setupBlockOne.inputTime
    readonly property int tempInputOne:     setupBlockOne.inputTemp
    readonly property int timeInputTwo:     setupBlockTwo.inputTime
    readonly property int tempInputTwo:     setupBlockTwo.inputTemp
    readonly property int timeInputThree:   setupBlockThree.inputTime
    readonly property int tempInputThree:   setupBlockThree.inputTemp
    readonly property int timeInputFour:    setupBlockFour.inputTime
    readonly property int tempInputFour:    setupBlockFour.inputTemp

    SetupBlock {id:setupBlockOne}
    SetupBlock {id:setupBlockTwo}
    SetupBlock {id:setupBlockThree}
    SetupBlock {id:setupBlockFour}
}
