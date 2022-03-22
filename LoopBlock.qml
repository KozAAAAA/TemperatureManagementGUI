import QtQuick 2.6
import QtQuick.Controls 2.0

Item
{

    readonly property int loopInput: loop.input
    height: loop.height
    width: loop.width

    InputBox
    {
        id: loop
        name: "Ilość pętli:"
        maxNumber: 999
    }

}
