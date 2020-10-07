import QtQuick 2.15
import QtQuick.Controls 2.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Button {
        anchors.centerIn: parent
        id: button
        visible: true
        width: 100
        height: 100
        text: "Go to Page1"
        onClicked: {
            pageLoader.source = "Page1.qml" //
            button.visible = false
        }
    }

    Loader {
        id: pageLoader
        focus: true
    }
}
