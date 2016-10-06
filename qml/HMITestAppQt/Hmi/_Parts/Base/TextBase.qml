import QtQuick 2.0

Text {

    property alias caption: textParts.text

    id: textParts;
    objectName: "TextParts"

    color: "white"
    font.pointSize: 16
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
