//import QtQuick 2.0

import QtQuick 2.2
import QtQuick.Window 2.0


import "Hmi/_Parts"
import "Hmi/_Parts/Base"



Rectangle {
    width: 800
    height: 480

    DialBase{
        id: dial
        value: 0
        //x:0
        //y: 0
        visible: true
        objectName: "speedgauge"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }


    Text{
        id: speedLabel
        text: "Speed and the meaning of life is: "
        x:40
        y:100
        width: 300
        height:40
    }

    Text{
       id: speedOutput
       text:""
       x:250
       y:100
       width:100
       height:40
    }

    function updateSpeed(speed){
        console.log(" inside updateSpeed")
        dial.value = speed;
    }

    Connections{
        target:signalinterface
        onUpdateSpeed:updateSpeed(speed)
    }
}
