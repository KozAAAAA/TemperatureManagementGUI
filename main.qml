import QtQuick 2.6
import QtQuick.Window 2.6

Window {
    width: 1920
    height: 1080
    visible: true
    //visibility: "FullScreen"
    title: qsTr("Hello World")


    TextInput
    {
        id: input
        text: "input text"
        onTextChanged: loopclass.changeValue(input.text)
    }


    Text
    {
        id: output
        y: 60
        text: "output"
        Connections
        {
            target: loopclass

            function onValueChanged(inputString)
            {
                output.text = inputString
            }
        }
    }
}
