import QtQuick 2.0

Item {

    id: spectrum
    visible: false
    implicitWidth: parent.width
    implicitHeight: 480

    Row{
        id: row
        height: 170
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.leftMargin: 50
        spacing: 5
        Repeater{
            model: 90
            delegate: Rectangle{
                id: delegate
                implicitWidth: parent.width/150
                implicitHeight: 150
                anchors.bottom: parent.bottom
                color: Qt.rgba(Math.random(),Math.random(),Math.random(),1);
                opacity: 0.6
                property int preVal;
                property int curVal;
                property color preCol : "red";
                property color curCol : "orange";

                ColorAnimation{
                    id: animation1
                    target: delegate
                    properties: "color"
                    from: "red"
                    to: "orange"
                    duration: 400
                }


                NumberAnimation{
                    id: animation2
                    target: delegate
                    properties: "implicitHeight"
                    from: delegate.preVal
                    to: delegate.curVal
                    duration: typeof (music.metaData.audioBitRate) !== "undefined" ? music.metaData.audioBitRate / 1000 : 200
                }

                Timer{
                    running: true
                    repeat: true
                    interval: 100
                    onTriggered:  {
                        delegate.preVal = delegate.curVal
                        delegate.curVal = Math.random()*100 + 50
                        animation1.start()
                        animation2.start()
                    }
                }
            }
        }
    }

}
