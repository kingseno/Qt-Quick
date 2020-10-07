import QtQuick 2.15
import QtQuick.Controls 2.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    // drag the Rectangle to see animation
    Flickable {
        anchors.left: parent.left
        width: 200
        height: 200
        contentHeight: 100
        contentWidth: 100
        onFlickStarted: {
            rect.color = "green"
        }

        onFlickEnded: {
            rect.color = "red"
        }

        Rectangle {
            id: rect
            width: 100
            height: 100
            color: "red"
        }
    }
}
