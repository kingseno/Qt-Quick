import QtQuick 2.15
import QtQuick.Controls 1.4

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    TabView {
         Tab {
             title: "Red"
             Rectangle { color: "red" }
         }
         Tab {
             title: "Blue"
             Rectangle { color: "blue" }
         }
         Tab {
             title: "Green"
             Rectangle { color: "green" }
         }
     }
}
