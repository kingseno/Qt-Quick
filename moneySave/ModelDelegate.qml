import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

ItemDelegate {
    id: root
    width: parent.width

    onClicked: console.log("clicked: ", name)

    RowLayout {
        spacing: 2
        anchors.fill: parent

        Image {
            Layout.alignment: Qt.AlignLeft
            source: url
            Layout.margins: 10
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft
            Text {
                text: type
                font.pixelSize: 16
                color: "black"
                //Layout.margins: 5
            }
            Text {
                text: note
                font.pixelSize: 12
                color: "black"
                opacity: 0.5
                //Layout.margins: 5
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Text {
            Layout.alignment: Qt.AlignRight
            text: label
            font.pixelSize: 32
            Layout.margins: 5
        }
    }
}
