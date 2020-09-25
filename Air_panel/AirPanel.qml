import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.14
import BackEnd 1.0

Item {
    id: info
    visible: !settingAir.visible
//    property HandleKey handleKey: null

    RowLayout {
        Text {
            text:qsTr("POWER: ")
            topPadding: 60
            leftPadding: 30
            font.pixelSize : 20
        }
        Text {
            text:txtPOWER.text
            topPadding: 60
            font.pixelSize : 20
        }
        Text {
            text:qsTr("Mode : ")
            topPadding: 60
            leftPadding: 10
            font.pixelSize : 20
        }
        Text {
            text:txtMode.text
            topPadding: 60
            font.pixelSize : 20
        }
        Text {
            text:qsTr("Alarm state: ")
            topPadding: 60
            leftPadding: 10
            font.pixelSize : 20
        }
        Text {
            text:txtAlarmState.text
            topPadding: 60
            font.pixelSize : 20
        }
    }
    RowLayout {
        Text {
            id: temp
            text: txtTemp.text
            topPadding: 110
            leftPadding: 140
            color: "red"
            font.pixelSize : 100
        }
        Text {
            text: qsTr("°C")
            color: "red"
            topPadding: 110
            leftPadding: 10
            font.pixelSize : 100
        }
    }
    RowLayout {
        Text {
            text:qsTr("Swing: ")
            topPadding: 275
            leftPadding: 100
            font.pixelSize : 20
        }
        Text {
            text:txtSwing.text
            topPadding: 275
            font.pixelSize : 20
        }
        Text {
            text:qsTr("Fan: ")
            topPadding: 275
            leftPadding: 10
            font.pixelSize : 20
        }
        Text {
            text:txtFan.text
            topPadding: 275
            rightPadding: 20
            font.pixelSize : 20
        }
        Image {
            anchors.bottom: parent.bottom
            sourceSize.width: 30
            sourceSize.height: 30
            source: "qrc:/images/alarm"
        }
        Text {
            text:txtTimer.text
            topPadding: 275
            font.pixelSize : 20
        }

    }
}
