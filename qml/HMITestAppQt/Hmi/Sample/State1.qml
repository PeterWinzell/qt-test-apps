import QtQuick 2.0

import "../_Parts"
import "../_Parts/Base"

LayoutBase {
    id: layoutbase
    width: 800
    height: 480

    focus: true

    DialBase{
        id: dial
        value: 0
        //x:0
        //y: 0
        visible: true
        objectName: "speedgauge"
    }
    
    function updateSpeed(speed){
    	dial.value = speed;
    }

    Connections{
	target:carSignalInterface
	onUpdateSpeed:updateSpeed(speed);
    }

    /*Rectangle {
        id: slider
        x: 20; y: 20;width: 30; height: 14
        color: "#424242"
        radius: 6
        visible: true
        smooth: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#424242" }
            GradientStop { position: 1.0; color: "black" }
        }

        MouseArea {
            anchors.fill: parent
            anchors.margins: -16 // Increase mouse area a lot outside the slider
            drag.target: parent; drag.axis: Drag.XAxis
            drag.minimumX: 2; drag.maximumX: layoutbase.width - 32
        }
    }*/

    ButtonBase {

        id: toState0_Button
        objectName: "ToState0_Button"
        x: 692
        y: 432
        visible: true
        caption: "Back"
        onReleased: {
            builtin.produceInternalEvent("toState0");
        }
    }
}
