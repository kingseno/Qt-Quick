import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import BackEnd 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Button {
        id: b1
        anchors.centerIn: parent
        text: "click here"
        onClicked: {
//            console.log(c1.price1);
            c1.setPrice2(20);
//            setContext.setPrice2(20);
        }
    }

    Config {
        id: c1
//        onPriceChanged: {
//            console.log("Check notification function")
//        }
//        onPrice1Changed: {
//            console.log("Check when property is changed")
//        }
    }

}
