import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    Rectangle {
        anchors.fill: parent
        color: 'red'
    }

    ColumnLayout {
        y: 100

        Button {
            Text {
                color: 'black'
                text: qsTr("Page1")
            }

            onClicked: loadPage('Page1')
        }

        Button {
            Text {
                text: qsTr("Page2")
            }

            onClicked: loadPage('Page2')
        }

        Button {
            Text {
                text: qsTr("Page3")
            }

            onClicked: loadPage('Page3')
        }
    }

}
