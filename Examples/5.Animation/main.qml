import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 900
    height: 900
    visible: true
    title: qsTr("Hello World")

    ColumnLayout {

        Rectangle {
            id: numberAnimation
            width: 100; height: 100
            color: "red"

            NumberAnimation on x {
                running: true
                loops: Animation.Infinite
                from: 0
                to: 900
                duration: 1000
            }
        }

        Rectangle {
            id: colorAnimation

            width: 100; height: 100
            color: "red"

            Rectangle {
                width: 100; height: 100
                color: "red"

                ColorAnimation on color {
                    running: true
                    loops: Animation.Infinite
                    from: "red"
                    to: "yellow"
                    duration: 1000
                }
            }
        }

        Rectangle {
            id: propertyAnimation
            width: 900; height: 100
            color: "red"

            // this is a standalone animation, it's not running by default
            PropertyAnimation {
                id: animation
                target: propertyAnimation
                property: "width"
                from: 900
                to: 30
                duration: 500
            }

            MouseArea {
                anchors.fill: parent
                onClicked: animation.running = true
            }
        }

        Rectangle {
            id: rotationAnimation
            width: 100
            height: 100
            color: "red"
            antialiasing: true

            RotationAnimation {
                running: true
                loops: Animation.Infinite
                duration: 1000
                from: 0
                to: 360
                target: rotationAnimation
            }
        }

        Rectangle {
            id: anchorAnimation
            width: 900
            height: 100
            color: "black"

            Rectangle {
                id: myRect
                width: 100
                height: 100
                color: "blue"

            }

            states: State {
                name: "reanchored"
                AnchorChanges {
                    target: myRect
                    anchors.right: anchorAnimation.right
                }
            }

            transitions: Transition {
                // smoothly reanchor myRect and move into new position
                AnchorAnimation {
                    running: true
                    loops: Animation.Infinite
                    duration: 1000
                }
            }

            Component.onCompleted: anchorAnimation.state = "reanchored"
        }

    }
}
