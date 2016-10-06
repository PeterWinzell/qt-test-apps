import QtQuick 2.0

Item {
        id: dialobject
        property real value : 0
        width: 800
        height: 480

        Image {
            id:dialbackground
            visible: true
            source: "../../../image/03_Dial/Speedo_no_pin.jpg"
            height: 480
            width: 800
        }

    //! [needle_shadow]
        Image {
            id:needleshadow
            x: 405
            y: 98
            width: 20
            height: 180
            visible: true
            anchors.verticalCenterOffset: -52
            source: "../../../image/03_Dial/needle_shadow.png"
            transform: Rotation {
                origin.x: 10
                origin.y: 180
                angle: needleRotation.angle
            }
        }
    //! [needle_shadow]

    //! [needle]
        Image {
            id: needle
            x: 397
            y: 98
            height: 180
            sourceSize.height: 63
            fillMode: Image.Stretch
            visible: true
            smooth: true
            source: "../../../image/03_Dial/needle.png"
            transform: Rotation {
                id: needleRotation
                origin.x:4
                origin.y:180
                //! [needle angle]
                angle: Math.min(Math.max(-130, dialobject.value*1.2 - 130), 133)
                Behavior on angle {
                    SpringAnimation {
                        spring: 1.4
                        damping: .15
                    }
                }
                //! [needle angle]
            }
        }
    //! [needle]
    //! [overlay]
        Image {
            id: centeroverlay
            x: 320
            y: 199
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 12
            anchors.horizontalCenterOffset: -6
            visible: true
            source: "../../../image/03_Dial/overlay.png"
        }
    //! [overlay]
}
