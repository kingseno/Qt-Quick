import QtQuick 2.15
import QtQuick.Controls 2.12 // you must import this library

ApplicationWindow { // change to Window => ApplicationWindow

    // then go to file: Rectangle.pro change "QT += quick" into "QT += quick quickcontrols2"
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: rect
        width: 200 // you must set width and height for Rectangle
        height: 200
        color: "red"
        border.color: "black"
        border.width: 5
        radius: 20
        anchors.centerIn: parent // align to the center position of its parent
        Text {
            id: text
            anchors.centerIn: parent
            font.pixelSize: 10
            text: qsTr("Example for rectangle")
            color: "black"
        }
    }

}
