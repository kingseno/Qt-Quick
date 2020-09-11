import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.calendar 1.0
import "./Alarm"
import "./CountDown"
import "./StopWatch"
import BackEnd 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 420
    height: 720
    maximumWidth: 420
    maximumHeight: 720
    minimumWidth: 420
    minimumHeight: 720
    title: qsTr(" Alarm12 Super ProMax")

    Config {
        id: config
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
//        Component.onCompleted: tabBar.currentIndex = 1
        currentIndex: tabBar.currentIndex

        Alarm {
            id: alarm
        }

        StopWatch {
            id: stopWatch
        }

        CountDown {
            id: countDown
        }
    }

    header: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            icon.name: "bell-regular"
            icon.width: 21
            icon.height: 24
        }
        TabButton {
            icon.name: "stopwatch-solid"
            icon.width: 21
            icon.height: 24
        }
        TabButton {
            icon.name: "hourglass-regular"
            icon.width: 21
            icon.height: 24
        }
    }

    Timer {
        id: timer
        function delay(delayTime, callBackFunction) {
            timer.interval = delayTime;
            timer.repeat = false;
            timer.triggered.connect(callBackFunction);
            timer.triggered.connect(function release () {
                timer.triggered.disconnect(callBackFunction);
                timer.triggered.disconnect(release);
            });
            timer.start();
        }
    }

}
