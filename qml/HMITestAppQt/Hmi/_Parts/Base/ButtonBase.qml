import QtQuick 2.0

BorderImage {

    property alias caption: caption.text

    signal pressed(var mouse)
    signal released(var mouse)

    id: button
    width: 100
    height: 40
    source: "../../../image/02_Button/01_Normal.gif"
    state: "Released"

    Text {
        id: caption
        width: parent.width
        height: parent.height
        text: "caption"
        color: "white"
        font.pointSize: 16
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        id: mouseArea
        width: parent.width
        height: parent.height

        onPressed: {
            parent.state = "Pressed"
            // signal[pressed]をコール
            button.pressed(mouse);
        }

        onReleased: {
            parent.state = "Released"
            // signal[released]をコール
            button.released(mouse);
        }
    }

    states: [
        State {
            name: "Pressed"
            PropertyChanges {
                target: button
                source: "../../../image/02_Button/02_Push.gif"
            }
        },
        State {
            name: "Released"
            PropertyChanges {
                target: button
                source: "../../../image/02_Button/01_Normal.gif"
            }
        }
    ]
}
