import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ColumnLayout {
        id: showAlarm
        spacing: 0
        anchors.fill: parent

        Label {
            id: bellLabel
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 30
            Layout.topMargin: 50

            Image {
                id: bell
                width: 60
                height: 80
                Layout.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/bell-solid.svg"
                smooth: true
                visible: true
            }

            ParallelAnimation { // all animations in it will run in parallel
                id: shakeBellAnimation
                loops: Animation.Infinite
                running: false

                SequentialAnimation { // all animations in it will run sequentially
                    RotationAnimator {
                        target: bellLabel
                        duration: 300
                        from: -40
                        to: 40
                    }
                    RotationAnimator {
                        target: bellLabel
                        duration: 300
                        from: 40
                        to: -40
                    }
                }

                ScaleAnimator {
                    target: bellLabel
                    from: 1
                    to: 2
                    duration: 600
                }
            }
        }


        RoundButton {
            id: turnOffAlarm
            text: "Turn on Animation"
            Layout.preferredWidth: 160
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignHCenter
            radius: 25
            font.capitalization: Font.Capitalize
            font.pixelSize: Qt.application.font.pixelSize * 1.4

            onClicked: {
                shakeBellAnimation.running = true
            }
        }

    }
}
