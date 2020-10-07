import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ColumnLayout { // import QtQuick.Layouts 1.12
        anchors.centerIn: parent
        Button {
            Layout.alignment: Qt.AlignHCenter // in a Layout you must use Layout. to set position and alignment, NOT anchors.
            text: "Push button"
            onClicked: txt.text = "Dog and iron man"
        }

        Text {
            id: txt
            Layout.alignment: Qt.AlignHCenter
            text: 'haha'
        }

        Image {
            id: img
            Layout.preferredWidth: 200 // can't use width, because img is in a Layout
            Layout.preferredHeight: 200
            source: "qrc:/iron-man.jpg"
        }
    }
}
