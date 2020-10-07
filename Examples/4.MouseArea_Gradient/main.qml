import QtQuick 2.15
import QtQuick.Controls 2.12


ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: rect1
        anchors.centerIn: parent
        width: 100
        height: 100
        color: 'green'
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            hoverEnabled: true
            onClicked: {
                if (mouse.button == Qt.RightButton)
                    parent.color = 'blue';
                else
                    parent.color = 'red';
            }

            onEntered: parent.color = 'black'
            onExited: parent.color = 'green'
        }
    }

    Rectangle {
        anchors.left: rect1.left
        anchors.top: rect1.bottom
        width: 100
        height: 100
        gradient: Gradient {
            GradientStop { position: 0.0; color: "red" }
            GradientStop { position: 0.33; color: "yellow" }
            GradientStop { position: 1.0; color: "green" }
        }

    }

}
