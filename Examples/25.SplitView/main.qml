import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // split screen

    SplitView {
         anchors.fill: parent
         orientation: Qt.Horizontal // choose the orientation of spliting

         Rectangle {
             implicitWidth: 200
             SplitView.maximumWidth: 400
             color: "lightblue"
             Label {
                 text: "View 1"
                 anchors.centerIn: parent
             }
         }
         Rectangle {
             id: centerItem
             SplitView.minimumWidth: 50
             SplitView.fillWidth: true
             color: "lightgray"
             Label {
                 text: "View 2"
                 anchors.centerIn: parent
             }
         }
         Rectangle {
             implicitWidth: 200
             color: "lightgreen"
             Label {
                 text: "View 3"
                 anchors.centerIn: parent
             }
         }
     }
}
