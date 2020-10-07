import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    ListModel {
        id: fileSystemModel
        ListElement {
            fileName: "A Masterpiece"
            filePermissions: "Gabriel"
        }
        ListElement {
            fileName: "Brilliance"
            filePermissions: "Jens"
        }
        ListElement {
            fileName: "Outstanding"
            filePermissions: "Frederik"
        }
    }

    TreeView {
         TableViewColumn {
             title: "Name"
             role: "fileName"
             width: 300
         }
         TableViewColumn {
             title: "Permissions"
             role: "filePermissions"
             width: 100
         }
         model: fileSystemModel
     }
}
