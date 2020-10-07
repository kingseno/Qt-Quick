import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    id: root

    signal signalToHideRect // you can't change properties by call id in dynamic object => see as below
    signal signalToShowRect

    function createDynamicObject() {
        let objString =
        'import QtQuick 2.15
        import QtQuick.Controls 2.12

        Rectangle {
            id: rect
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100
            height: 100
            color: "red"

            function hideRect() {
                rect.visible = false
            }

            function showRect() {
                rect.visible = true
            }

            Component.onCompleted: {
                root.signalToHideRect.connect(hideRect) // connect signal to internal function to change properties
                root.signalToShowRect.connect(showRect)
            }
        }'

        let newTimer = Qt.createQmlObject(
                    objString, // string to create dynamic object
                    root, // parent which contains the object
                    "Error to Create rectangle"); // this string will display when can't create object

    }

    ColumnLayout {
        anchors.centerIn: parent
        Button {
            Text {
                anchors.centerIn: parent
                id: showRect
                text: qsTr("Show")
            }

            onClicked: signalToShowRect() // call signal
        }

        Button {
            Text {
                anchors.centerIn: parent
                id: hideRect
                text: qsTr("Hide")
            }

            onClicked: signalToHideRect()
        }
    }

    Component.onCompleted: createDynamicObject()
}
