/****************************************************************************
**
** Author: Dinh Pham
** Desciption:
****************************************************************************/

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3


ItemDelegate {
    id: root
    width: parent.width
    checkable: true
    onPressAndHold:  {

    }

    onClicked: ListView.view.currentIndex = index

    contentItem: ColumnLayout {
        spacing: 0
        id: alarmElement

        RowLayout {
            ColumnLayout {
                id: dateColumn

                readonly property date alarmDate: new Date(
                    model.year, model.month - 1, model.day, model.hour,
                                                      model.minute)

                Label {
                    id: timeLabel
                    font.pixelSize: Qt.application.font.pixelSize * 2
                    text: dateColumn.alarmDate
                    .toLocaleTimeString(window.locale, Locale.ShortFormat)
                }
                RowLayout {
                    Label {
                        id: dateLabel
                        text: dateColumn.alarmDate
                        .toLocaleDateString(window.locale, Locale.ShortFormat)
                    }
                    Label {
                        id: alarmAbout
                        text: "-> " + model.label
                        visible: model.label.length > 0 && !root.checked
                    }
                }
            }
            Item {
                Layout.fillWidth: true
            }
            Switch {
                id: switchToTurnOnAlarm
                checked: model.activated
                Layout.alignment: Qt.AlignTop
                onClicked: {
                    model.activated = checked
                    checked ? alarmElement.opacity = 1
                            : alarmElement.opacity = 0.3

                    // can't return a object from function as javascript
                    // so I must write code directly in here
                    // this block of code is to get remain time to show the notification
                    var currentTime = new Date()
                    currentTime = currentTime.getHours() * 60
                                  + currentTime.getMinutes()

                    var alarmTime = dateColumn.alarmDate.getHours() * 60
                                    + dateColumn.alarmDate.getMinutes()

                    var remainTime = {
                        hours: (alarmTime - currentTime) / 60,
                        minutes: (alarmTime - currentTime) % 60
                    }

                    remainTime.hours < 0 ? remainTime.hours += 24
                                         : remainTime.hours

                    remainTime.minutes < 0 ? remainTime.minutes += 60
                                         : remainTime.minutes

                    notificationText.text = "Alarm will go off in "
                                            + Math.floor(remainTime.hours)
                                            + " hours and "
                                            + remainTime.minutes
                                            + " minutes"

//                    if (checked) alarm.state = "showNotification"
//                    else {
//                        notification.y -= 50
//                        notification.opacity = 0
//                        alarm.state = "hideNotification"
//                    }
                    if (checked) {
                        showAnimation.start()
                        timer.delay(3000, hideAnimation.start)
                    }

                }
                Component.onCompleted: checked ? alarmElement.opacity = 1
                                               : alarmElement.opacity = 0.3
            }
        }
        CheckBox {
            id: alarmRepeat
            text: qsTr("Repeat")
            checked: model.repeat
            visible: root.checked
            onToggled: model.repeat = checked
        }
        Flow {
            visible: root.checked && model.repeat
            Layout.fillWidth: true

            Repeater {
                id: dayRepeater
                model: daysToRepeat
                delegate: RoundButton {
                    text: Qt.locale().dayName(model.dayOfWeek, Locale.NarrowFormat)
                    flat: true
                    checked: model.repeat
                    checkable: true
                    Material.background: checked ? Material.accent : "transparent"
                    onToggled: model.repeat = checked
                }
            }
        }

        TextField {
            id: alarmDescriptionTextField
            Layout.fillWidth: true
            placeholderText: qsTr("Enter description here")
            cursorVisible: true
            visible: root.checked
            text: model.label
            onTextEdited: {
                model.label = text
                root.checkable = false
            }
            onAccepted: {
                root.checkable = true
                root.checked = false

                alarmListView.sendInfoToCplusplus()

            }
        }
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            RoundButton {
                id: saveAlarmButton
                text: qsTr("SAVE")
                Layout.topMargin: 5
                Layout.preferredWidth: 160
                height: 40
                radius: 20
                visible: root.checked
                onClicked: {
                    root.checkable = true

                    alarmListView.sendInfoToCplusplus()
                }
            }
            RoundButton {
                id: deleteAlarmButton
                text: qsTr("Delete")
                Layout.topMargin: 5
                Layout.preferredWidth: 160
                height: 40
                radius: 20
                visible: root.checked
                onClicked: {
                    root.ListView.view.model.remove(root.ListView.view.currentIndex, 1)
                    alarmListView.sendInfoToCplusplus()
                }
            }
        }
    }
}

