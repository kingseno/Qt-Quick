import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    anchors.fill: parent
    anchors.leftMargin: 500

    TumBlerTimer{
        id: tumbler
    }

    Switch{
        id: sWitch
        implicitHeight: 40
        implicitWidth: 300
        anchors.leftMargin: 300
        text: "<strong>" + "Sleep Timer" + "</strong>"
        onPositionChanged: {
            if(position == 1){
                console.log("Turn on timer");
                tumbler.open();
                showTimerShutDown.visible = true;
                timer.running = true;
            }else {
                showTimerShutDown.visible = false;
                tumbler.close();
                console.log("Turn off timer");
                timer.stop();
            }
        }
    }

    Rectangle{
        id: showTimerShutDown
        anchors.top: sWitch.bottom
        radius: 10
        implicitHeight: 60
        implicitWidth: sWitch.implicitWidth
        gradient: Gradient {
            GradientStop {
                position: 0.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14148c"; to: "#0E1533"; duration: 5000 }
                    ColorAnimation { from: "#0E1533"; to: "#14148c"; duration: 5000 }
                }
            }
            GradientStop {
                position: 1.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14aaff"; to: "#437284"; duration: 5000 }
                    ColorAnimation { from: "#437284"; to: "#14aaff"; duration: 5000 }
                }
            }
        }
        visible: false
        Text{
            font.pointSize: 15
            anchors.centerIn: parent
            font.bold: true
            color:'white'
            text: tumbler.hoursTumbler.currentIndex + 1 + " : " +  (tumbler.minutesTumbler.currentIndex.toString().length > 1 ? tumbler.minutesTumbler.currentIndex: "0" + tumbler.minutesTumbler.currentIndex) + " " + (tumbler.amPmTumbler.currentIndex === 0 ? "AM":"PM")
        }
        MouseArea {
            id: iMouseArea
            anchors.fill: parent
            onClicked: tumbler.open();
        }
    }

    ListModel{
        id :contactModel
        ListElement{
            name: "qrc:/Pictures/nct.jpg"
        }
        ListElement{
            name: "qrc:/Pictures/zingmp3.png"
        }
        ListElement{
            name: "qrc:/Pictures/nhac_vn.png"
        }
        ListElement{
            name: "qrc:/Pictures/keeng.png"
        }
        ListElement{
            name: "qrc:/Pictures/youtube.png"
        }
        ListElement{
            name: "qrc:/Pictures/imuzik.png"
        }

    }

    Text{
        id: textMusicOnline
        anchors.top : showTimerShutDown.bottom
        anchors.topMargin: 20
        text: "Music Online"
        font.pointSize: 15
        color: 'white'
        font.bold: true
    }

    GridView{
        id: gridView
        anchors.top : textMusicOnline.bottom
        anchors.topMargin: 20
        width: 350; height: 230
        cellHeight: 100
        cellWidth: 100
        model: contactModel
        delegate: Image {
            source: name
            sourceSize.width:  100
            sourceSize.height:  100
            MouseArea {
                id: iMouseImage
                anchors.fill: parent
                onClicked: {
                    gridView.currentIndex = index
                    service.openService(gridView.currentIndex);
                }
            }
        }
    }

    property int hours: tumbler.hoursTumbler.currentIndex + 1
    property int minutes: tumbler.minutesTumbler.currentIndex
    property int transmitAmPmTo24H: tumbler.amPmTumbler.currentIndex == 0 ? 0 : 12

    function timeToMs(){
        var timeNow = new Date();
        var hour = hours - timeNow.getHours() + transmitAmPmTo24H;
        var minute = minutes - timeNow.getMinutes();
        var second = hour * 3600 + minute*60 + timeNow.getSeconds();
        return second * 1000;
    }

    Timer {
        id: timer
        interval: timeToMs()
        running: false;
        onTriggered: root.close();
    }


}
