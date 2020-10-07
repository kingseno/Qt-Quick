import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Image {
        anchors.centerIn: parent
        id: img
        source: "qrc:/image.jpg"

        PinchArea {
            enabled: true
            anchors.fill: parent
            pinch.target: parent

            pinch.minimumScale: 0.5
            pinch.maximumScale: 2.0

            pinch.minimumRotation: -360
            pinch.maximumRotation: 360

            pinch.dragAxis: Pinch.XAxis
        }
    }
}
