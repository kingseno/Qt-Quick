import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.4

ApplicationWindow {
    id: tui
    visible: true
    width: 150; height: 80
    maximumHeight: 80
    maximumWidth: 150

    property TimerSave target: null;

    Text {
        x: 7
        y: 0
        text: qsTr("Name already exists,
Do you want to override?")
    }

    Button{
        id: ok
        x: 94
        y: 46
        width: 44
        height: 28
        text: "OK"
        onClicked: {
           target.is_override = true;
           target.saveconfig()
           target.backmain()
           tui.close()
        }
    }
    Button{
        id: no
        x: 35
        y: 46
        width: 44
        height: 28
        text: "NO"
        onClicked: {
            target.is_override = false;
            tui.close()
        }

     }

    onClosing:{
        target.enablemain();
       }
}
