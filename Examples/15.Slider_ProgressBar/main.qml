import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ColumnLayout {
        anchors.fill: parent

        ProgressBar {
            Layout.alignment: Qt.AlignHCenter
            id: progressBar
            from: 0
            value: slider.value
            to: 100
        }

        Slider {
            Layout.alignment: Qt.AlignHCenter
            id: slider
            from: 0
            value: 0
            to: 100
            stepSize: 1
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            id: name
            text: slider.value
        }

    }

}
