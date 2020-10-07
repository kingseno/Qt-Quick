import QtQuick 2.15
import QtQuick.Controls 2.12


ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: page
        anchors.fill: parent
        color: "lightgray"

        Text {
            id: helloText
            text: "Hello world!" // hold on this test to see the animation
            y: 30
            anchors.horizontalCenter: page.horizontalCenter
            font.pointSize: 24; font.bold: true

            MouseArea { id: mouseArea; anchors.fill: parent }

            states: State {
                name: "down"; when: mouseArea.pressed === true
                PropertyChanges { target: helloText; y: 160; rotation: 180; color: "red" }
            }

            transitions: Transition {
                from: ""; to: "down"; reversible: true
                ParallelAnimation {
                    NumberAnimation { properties: "y,rotation"; duration: 500; easing.type: Easing.InOutQuad }
                    ColorAnimation { duration: 500 }
                }
            }
        }
    }
}
