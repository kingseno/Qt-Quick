import QtQuick 2.15
import QtQuick.Controls 2.12

ApplicationWindow {
    width: 640
    height: 640
    visible: true
    title: qsTr("Hello World")

    ListView {
        id: listView
        anchors.margins: 10
        anchors.fill: parent
        spacing: 20
        model: ListModel {
            ListElement {
                label: "May be you don't know"
                myColor: 'red'
            }
            ListElement {
                label: "At Bosch and BV have a special position of developer"
                myColor: "green"
            }
            ListElement {
                label: "It just is test case developer"
                myColor: "black"
            }
        }
        delegate: Rectangle { // delegate is used to choose element to display with infos which come from ListElement
            border.color: 'red'
            border.width: 1
            width: parent.width
            height: 100
            Text {
                anchors.centerIn: parent
                color: myColor // from ListElement
                text: label  // from ListElement
            }

        }
    }

    Button {
        width: 200
        height: 50
        Text {
            anchors.centerIn: parent
            font.pixelSize: 20
            text: qsTr("Add a element")
        }
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        onClicked: listView.model.append({
                                             label: "It is your destiny",
                                             myColor: "gray"
                                         })
    }
}
