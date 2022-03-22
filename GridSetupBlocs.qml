import QtQuick 2.0


Grid {
    columns: 2
    spacing: 50

    readonly property int setupBlock_1_timeInput: setupblock1.timeInput
    readonly property int setupBlock_1_tempInput: setupblock1.tempInput
    readonly property int setupBlock_2_timeInput: setupblock2.timeInput
    readonly property int setupBlock_2_tempInput: setupblock2.tempInput
    readonly property int setupBlock_3_timeInput: setupblock3.timeInput
    readonly property int setupBlock_3_tempInput: setupblock3.tempInput
    readonly property int setupBlock_4_timeInput: setupblock4.timeInput
    readonly property int setupBlock_4_tempInput: setupblock4.tempInput

    SetupBlock {id:setupblock1}
    SetupBlock {id:setupblock2}
    SetupBlock {id:setupblock3}
    SetupBlock {id:setupblock4}
}
