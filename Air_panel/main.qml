import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.4
import BackEnd 1.0

Window {
    id: main
    visible: true
    width: 500
    height: 400
    maximumHeight: 400
    maximumWidth: 500
    title: qsTr("Air panel control")
    Data {
        id: data
    }

    Custom{
        id: custom
    }

    HandleKey {
        id: handleKey
    }

//    Item {
//        id: showconfid
//        property string L1: "LOW"
//    }

    Hardware{
        id:hardware
    }
	Config{
    	id:config
    }
    Text {
        id: txtFan
        text: qsTr("LOW")
    }
    Text {
        id: txtSwing
        text: qsTr("UP")
    }
    Text {
        id: txtMode
        text: qsTr("NORMAL")
    }
    Text {
        id: txtAlarmState
        text: qsTr("OFF")
    }
    Text {
        id: txtTimer
        text: qsTr("None")
    }
    Text {
        id: txtPOWER
        text: qsTr("ON")
    }
    Text {
        id: txtTemp
        text: "20"
    }


    Rectangle {
        width: 500
        height: 400
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightblue" }
            GradientStop { position: 1.0; color: "white" }
        }

        Component.onCompleted: {
            data.currentDateTime();
        }
    }

    ColumnLayout {
        width: 500
        spacing: 20

        Rectangle {
            height: 325
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            antialiasing: true
            border.color: "black"
            radius: 10
            Text {
                id: dtDateTime
                color: "blue"
                padding: 10
                leftPadding: 70
                font.pixelSize: 30
                text: data.dateTime
            }
            AirPanel {
                id: panel
                visible: true
//                handleKey: handleKey
            }
            Setting {
                id: setting
                visible: false
            }
            UserList {
                id: userList
                visible: false
            }

        }

     ButtonBar{
         id: buttonBar
         visible: true
//         handleKey: handleKey
     }
    }

}
