import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    FileDialog {
         id: fileDialog
         title: "Please choose a file"
         folder: shortcuts.home
         onAccepted: {
             console.log("You chose: " + fileDialog.fileUrls)
             Qt.quit()
         }
         onRejected: {
             console.log("Canceled")
             Qt.quit()
         }
     }

    Button {
        anchors.centerIn: parent
        Text {
            anchors.centerIn: parent
            id: open
            text: qsTr("Open File")
        }

        onClicked: fileDialog.open()
    }
}
