import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ColumnLayout {
        anchors.centerIn: parent
        TextField {
            id: txtField
            Layout.alignment: Qt.AlignHCenter
            placeholderText: qsTr("Enter description here")
            cursorVisible: true
            visible: true
            onTextEdited: {
                txt.text = text // in {} scope, you can write javascript code
                // set property "text" of txt object to text of txtField
            }
        }

        Text {
            id: txt
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("text")
        }
    }

}
