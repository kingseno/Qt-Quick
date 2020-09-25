import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.2

Dialog {
    id: tumblerTimer
    height: fram.height + label.height + 50
    width: fram.width + 50
    visible: true
    property alias hoursTumbler: hoursTumbler
    property alias minutesTumbler: minutesTumbler
    property alias amPmTumbler: amPmTumbler

    MouseArea {
        id: iMouseArea
        property int prevX: 0
        property int prevY: 0
        anchors.fill: parent
        onPressed: { prevX = mouse.x; prevY = mouse.y }
        onPositionChanged:{
            var deltaX = mouse.x - prevX;
            tumblerTimer.x += deltaX;
            prevX = mouse.x - deltaX;

            var deltaY = mouse.y - prevY
            tumblerTimer.y += deltaY;
            prevY = mouse.y - deltaY;
        }
    }

    Label{
        id: label
        height: text.height
        width: parent.width
        Text{
            id: text
            anchors.centerIn: parent
            text: "Set Time To Stop Playing Music"
            color: 'white'
            font.pixelSize: fontMetrics.font.pixelSize * 1.25
        }
    }

    function formatText(count, modelData) {
        var data = count === 12 ? modelData + 1 : modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }

    FontMetrics {
        id: fontMetrics
    }

    Component {
        id: delegateComponent

        Label {
            text: formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: fontMetrics.font.pixelSize * 1.25
        }
    }
    Frame{
        id: fram
        anchors.top: label.bottom
        anchors.margins: 10

        Row{
            antialiasing: true
            Tumbler{
                id: hoursTumbler
                model: 12
                delegate: delegateComponent
            }
            Tumbler{
                id: minutesTumbler
                model: 60
                delegate: delegateComponent
            }
            Tumbler{
                id: amPmTumbler
                model: ["AM", "PM"]
                delegate: delegateComponent
            }
        }
    }

    Component.onCompleted: tumblerTimer.close()

}
