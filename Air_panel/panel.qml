import QtQuick 2.4

Rectangle {
    id: info
    visible: true
    height: 325
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 5
    antialiasing: true
    border.color: "black"
    radius: 10
    property alias couter: temp.text
    Text {
        id: temp
        text: qsTr("20")
        color: "red"
        font.pixelSize : 80
    }
    Text {
        text: qsTr("°C")
        color: "red"
        font.pixelSize : 80
    }
    Text {
        id: dateTime
        color: "blue"
        font.pixelSize: 30
        text: getDateTime()
        onTextChanged: {
             dateTime.text = getDateTime()
        }
    }
}
