import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    Rectangle {
        anchors.fill: parent
        color: 'blue'
    }

    Button {
        anchors.centerIn: parent
        Text {
            anchors.centerIn: parent
            color: 'black'
            text: qsTr("Exit")
        }

        onClicked: stack.pop()
    }
}
