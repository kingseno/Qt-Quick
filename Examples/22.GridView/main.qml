import QtQuick 2.15
import QtQuick.Controls 2.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    // like List View
    ListModel {
        id: contactModel
        ListElement {
            name: "Jim Williams"
            old: "20"
        }
        ListElement {
            name: "John Brown"
            old: "21"
        }
        ListElement {
            name: "Bill Smyth"
            old: "22"
        }
        ListElement {
            name: "Sam Wise"
            old: "23"
        }
        ListElement {
            name: "Sam Wise"
            old: "23"
        }
    }

    GridView {
        width: 300; height: 200

        model: contactModel
        delegate: Column {
            Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
            Text { text: old; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }

}
