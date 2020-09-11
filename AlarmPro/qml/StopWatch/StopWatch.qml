import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0

Item {
    ColumnLayout {
        id: showAlarm
        spacing: 0
        Layout.fillWidth: parent
        Layout.fillHeight: parent
        anchors.centerIn: parent

        Label {
            id: bellLabel
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 100
            Image {
                id: bell
                width: 60
                height: 80
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/icons/alarm/32x32/bell-solid.svg"
                smooth: true
                visible: false
            }
            ColorOverlay {
                anchors.fill: bell
                source: bell
                color: "white"
            }

            ParallelAnimation {
                loops: Animation.Infinite
                running: true

                SequentialAnimation {
                    RotationAnimator {
                        target: bellLabel
                        duration: 200
                        from: -40
                        to: 40
                    }
                    RotationAnimator {
                        target: bellLabel
                        duration: 200
                        from: 40
                        to: -40
                    }
                }

                ScaleAnimator {
                    target: bellLabel
                    from: 1
                    to: 2
                    duration: 400
                }
//                PauseAnimation { duration: 500 }
            }
        }

        Text {
            id: shakeText
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 100
            text: "Alarm 6:00 PM"
            font.pixelSize: Qt.application.font.pixelSize * 1.4
            color: "white"
            wrapMode: Text.WordWrap
        }

        RoundButton {
            id: turnOffAlarm
            text: "Turn Off"
            Layout.preferredWidth: 160
            Layout.preferredHeight: 50
            radius: 25
            font.capitalization: Font.Capitalize
            font.pixelSize: Qt.application.font.pixelSize * 1.4
        }

    }

}
