/****************************************************************************
**
** Author: Dinh Pham
** Desciption:
****************************************************************************/

import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
//    id:
    ListView {
        id: alarmListView
        anchors.margins: 5
        anchors.fill: parent
        model: AlarmModel {}
        delegate: AlarmDelegate {}

        function sendInfoToCplusplus() {
            var infoFromListModel = []
            for(var i = 0 ; i < alarmListView.model.count; i++) {
                infoFromListModel.push({
                   hour: alarmListView.model.get(i).hour,
                   minute: alarmListView.model.get(i).minute,
                   day: alarmListView.model.get(i).day,
                   month: alarmListView.model.get(i).month,
                   year: alarmListView.model.get(i).year,
                   activated: alarmListView.model.get(i).activated,
                   label: alarmListView.model.get(i).label,
                   repeat: alarmListView.model.get(i).repeat,
                   daysToRepeat: [
                        { dayOfWeek: alarmListView.model.get(i).
                                                   daysToRepeat.get(0).dayOfWeek,
                            repeat: alarmListView.model.get(i).
                                                   daysToRepeat.get(0).repeat },
                        { dayOfWeek: alarmListView.model.get(i).
                                                   daysToRepeat.get(1).dayOfWeek,
                            repeat: alarmListView.model.get(i).
                                                   daysToRepeat.get(1).repeat },
                        { dayOfWeek: alarmListView.model.get(i).
                                                   daysToRepeat.get(2).dayOfWeek,
                            repeat: alarmListView.model.get(i).
                                                   daysToRepeat.get(2).repeat },
                        { dayOfWeek: alarmListView.model.get(i).
                                                   daysToRepeat.get(3).dayOfWeek,
                            repeat: alarmListView.model.get(i).
                                                   daysToRepeat.get(3).repeat },
                        { dayOfWeek: alarmListView.model.get(i).
                                                   daysToRepeat.get(4).dayOfWeek,
                            repeat: alarmListView.model.get(i).
                                                   daysToRepeat.get(4).repeat },
                        { dayOfWeek: alarmListView.model.get(i).
                                                   daysToRepeat.get(5).dayOfWeek,
                            repeat: alarmListView.model.get(i).
                                                   daysToRepeat.get(5).repeat },
                        { dayOfWeek: alarmListView.model.get(i).
                                                   daysToRepeat.get(6).dayOfWeek,
                            repeat: alarmListView.model.get(i).
                                                   daysToRepeat.get(6).repeat }
                    ]
                })
            }

            config.saveChanges(infoFromListModel)
        }
    }

    RoundButton {
        id: addAlarmButton
        icon.name: "plus-solid"
        icon.width: 18
        icon.height: 20

        width: 70
        height: 70
        anchors.bottom: alarmListView.bottom
        anchors.bottomMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: alarmDialog.open()
    }

    AlarmDialog {
        id: alarmDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        alarmModel: alarmListView.model
    }

    Rectangle {
        id: notification
        visible: false
        width: parent.width * 0.8
        height: 50
        radius: 10

        y: addAlarmButton.y - notification.height
        z: 999

        color: "#404040"

        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: notificationText
            anchors.centerIn: parent
            text: "Alarm will go off in 8 hours and 30 minutes"
            width: parent.width * 0.9
            font.pixelSize: Qt.application.font.pixelSize * 1.4
            color: "white"
            wrapMode: Text.WordWrap
        }


        ParallelAnimation {
            id: showAnimation
            running: false

            NumberAnimation {
                target: notification
                property: "opacity"
                duration: 300
                from: 0
                to: 1
                easing.type: Easing.OutBack
            }
            NumberAnimation {
                target: notification
                property: "y"
                duration: 300
                from: addAlarmButton.y - notification.height
                to: addAlarmButton.y - notification.height - 50
                easing.type: Easing.OutBack
            }
            ScaleAnimator {
                target: notification
                from: 0
                to: 1
                duration: 300
            }

            onStarted: notification.visible = true
        }

        ParallelAnimation {
            id: hideAnimation
            running: false

            NumberAnimation {
                target: notification
                property: "opacity"
                duration: 300
                from: 1
                to: 0
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: notification
                property: "y"
                duration: 300
                from: addAlarmButton.y - notification.height - 50
                to: addAlarmButton.y - notification.height
                easing.type: Easing.OutCubic
            }

            ScaleAnimator {
                target: notification
                from: 1
                to: 0
                duration: 300
            }
        }
    }

//    states: [
//        State {
//            name: "hideNotification"
//            PropertyChanges {
//                target: notification
//                visible: true
//                opacity: 0
//                y: addAlarmButton.y - notification.height
//            }
//        },
//        State {
//            name: "showNotification"
//            PropertyChanges {
//                target: notification
//                visible: true
//                opacity: 1
//                y: addAlarmButton.y - notification.height - 50
//            }
//        }
//    ]

//    transitions: [
//        Transition {
//            from: "*"
//            to: "*"
//            PropertyAnimation {
//                duration: 200
//                target: notification
//                properties: "opacity"
//                easing.type: Easing.OutBack
//            }
//            PropertyAnimation {
//                duration: 200
//                target: notification
//                properties: "y"
//                easing.type: Easing.OutBack
//            }
//        }
//    ]
}
