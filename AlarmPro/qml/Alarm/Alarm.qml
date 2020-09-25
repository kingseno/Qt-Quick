/****************************************************************************
** Project                  = Alarm13 Super ProMax
** Author                   = Dinh Pham
** Version                  = V1.0.0
** Date                     = 23/09/2020
**
*****************************************************************************
** Purpose of this file:
**
*****************************************************************************
** Lisense
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** Copyright (C) 2020 by Dinh Pham
**
*****************************************************************************
**                      Revision Control History
** V1.0.0:  23/09/2020  : Initial version.
**
****************************************************************************/

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.15

Item {
    id: alarmScreen
    ListView {
        id: alarmListView
        anchors.margins: 5
        anchors.fill: parent
        model: AlarmModel {}
        delegate: AlarmDelegate {}

//        onCurrentItemChanged: alarmListView.handleAlarm()

        function sendInfoToCplusplus() {
            let infoFromListModel = []
            for(let i = 0 ; i < alarmListView.model.count; i++) {
                infoFromListModel.push({
                   hour: alarmListView.model.get(i).hour,
                   minute: alarmListView.model.get(i).minute,
//                   day: alarmListView.model.get(i).day,
//                   month: alarmListView.model.get(i).month,
//                   year: alarmListView.model.get(i).year,
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

        function handleAlarm() {
            //get info from a alarm
            let infoToAlarm = []
            for (var i = 0 ; i < alarmListView.model.count; i++) {
                infoToAlarm.push({
                   hour: alarmListView.model.get(i).hour,
                   minute: alarmListView.model.get(i).minute,
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

//            console.log(JSON.stringify(infoToAlarm))

            //compare and caculate remaining time
            let currentTime = new Date()
//            currentTime.setHours(10, 0, 0);
            let alarmTime = new Date()
            let deltaTime = new Date()
            let remainingTime = {
                days: 0,
                hours : 0,
                minutes : 0,
                seconds: 0,
                getRemainingTimeBySeconds: function() {
                    return this.days * 86400 + this.hours * 3600
                            + this.minutes * 60 + this.seconds
                }
            }
            let minRemainingDays = 9
            let indexOfLast = infoToAlarm.length - 1

            alarmTime.setHours(infoToAlarm[indexOfLast].hour, infoToAlarm[indexOfLast].minute, 0);

            if (infoToAlarm[indexOfLast].activated) {
                if (!infoToAlarm[indexOfLast].repeat) {
                    alarmTime.setDate(currentTime.getDate() + 1)

                    deltaTime.setTime(alarmTime.getTime()
                                                 - currentTime.getTime())

                    remainingTime.hours = deltaTime.getUTCHours()
                    remainingTime.minutes = deltaTime.getMinutes()
                    remainingTime.seconds = deltaTime.getSeconds()
                    console.log("Remain Time: ", JSON.stringify(remainingTime))
                } else {
                    let arr = []
                    for (let i = 0; i < infoToAlarm[indexOfLast].daysToRepeat.length; i++) {
                        if (infoToAlarm[indexOfLast].daysToRepeat[i].repeat) {
                            if (infoToAlarm[indexOfLast].daysToRepeat[i].dayOfWeek > currentTime.getDay()) {

                                alarmTime.setDate(currentTime.getDate()
                                                  + infoToAlarm[indexOfLast].daysToRepeat[i].dayOfWeek
                                                  - currentTime.getDay())

                            } else {
                                alarmTime.setDate(currentTime.getDate()
                                                  + infoToAlarm[indexOfLast].daysToRepeat[i].dayOfWeek
                                                  - currentTime.getDay() + 7)
                            }

                            deltaTime.setTime(alarmTime.getTime()
                                                         - currentTime.getTime())

                            remainingTime.hours = deltaTime.getUTCHours()
                            remainingTime.minutes = deltaTime.getMinutes()
                            remainingTime.seconds = deltaTime.getSeconds()
                            deltaTime.getDate() === 8 ? remainingTime.days = 0
                                                     : remainingTime.days = deltaTime.getDate() - 1
                            if (minRemainingDays > remainingTime.days)
                                minRemainingDays = remainingTime.days

                        }

                        if (minRemainingDays === 9) {
                            alarmTime.setDate(currentTime.getDate() + 1)

                            deltaTime.setTime(alarmTime.getTime()
                                                         - currentTime.getTime())

                            remainingTime.hours = deltaTime.getUTCHours()
                            remainingTime.minutes = deltaTime.getMinutes()
                            remainingTime.seconds = deltaTime.getSeconds()
                        } else {
                            // this code to handle bug which happens when
                            // 0 < currentTime - alarmTime < 7 hours
                            var timeBug =
                                (currentTime.getHours() * 3600 + currentTime.getMinutes() * 60
                                 + currentTime.getSeconds())
                                - (alarmTime.getHours() * 3600 + alarmTime.getMinutes() * 60
                                   + alarmTime.getSeconds())
//                            console.log(timeBug)
                        }

                    }
                    minRemainingDays === 9 ? remainingTime.days = 0
                                           : remainingTime.days = minRemainingDays

                    // this code to handle bug which happens when
                    // 0 < currentTime - alarmTime < 7 hours
                    if (timeBug > 0 && timeBug <= 7 * 3600) {
                        remainingTime.days === 0 ? remainingTime.days = 6
                                                 : remainingTime.days -= 1
                    }

//                    console.log(currentTime)
//                    console.log(alarmTime)

                    console.log("Remain Time: ", JSON.stringify(remainingTime))

                }
            }

            //trigger and display notification

            console.log("Remain Time by seconds: ", remainingTime.getRemainingTimeBySeconds())

            let objString =
                            "import QtQuick 2.12
                            import QtQuick.Controls 2.5

                            Timer {
                                id: timer1
                                function delay(delayTime, callBackFunction) {
                                    interval = delayTime
                                    repeat = false
                                    triggered.connect(callBackFunction)
                                    triggered.connect(function release () {
                                        triggered.disconnect(callBackFunction)
                                        triggered.disconnect(release)
                                    })
                                    start()
                                }
                            }"

            let newTimer = Qt.createQmlObject(
                        objString,
                        alarmScreen,
                        "error.txt");

            function displayAlarm() {
                popup.open()
                shakeText.text = "Alarm " +  alarmTime
                    .toLocaleTimeString(window.locale, Locale.ShortFormat)
                shakeBellAnimation.start()
                playMusic.play()
            }

            newTimer.delay(1000 * remainingTime.getRemainingTimeBySeconds(), displayAlarm)

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

    Popup
    {
        id: popup

        anchors.centerIn: parent
        width: parent.width * 0.8
        height: parent.height * 0.7
        modal: true
        focus: true

        closePolicy: Popup.CloseOnEscape

        leftPadding: 0;
        rightPadding: 0;
        topPadding: 0;
        bottomPadding: 0;

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
                    id: shakeBellAnimation
                    loops: Animation.Infinite
                    running: true

                    SequentialAnimation {
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

            Text {
                id: shakeText
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 0
                text: "Alarm 13:00 PM"
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                color: "white"
                wrapMode: Text.WordWrap
            }

            RoundButton {
                id: turnOffAlarm
                text: "Turn Off"
                Layout.preferredWidth: 160
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter
                radius: 25
                font.capitalization: Font.Capitalize
                font.pixelSize: Qt.application.font.pixelSize * 1.4

                onClicked: {
                    popup.close()
                    playMusic.stop()
//                    alarmListView.handleAlarm()
                }
            }

        }

        DropShadow {
            width: popup.width;
            height: popup.height;

            source: showAlarm;

            horizontalOffset: 0;
            verticalOffset: 5;
            radius: 10;
            samples: 7;
            color: "black";
        }

        onOpened: theBlur.visible = true;
        onClosed: theBlur.visible = false;
    }

    GaussianBlur
    {
        id: theBlur;
        visible: false;
        anchors.fill: alarmListView;
        source: alarmListView;
        radius: 8
        samples: 16
    }

    Audio {
        id: playMusic
        source: "qrc:/music/lovingly.mp3"
        loops: Audio.Infinite
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
