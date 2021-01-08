import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 915
    height: 570
    title: qsTr("Hello World")
    id: root

    ListView {
        id: listview
        width: 915
        height: 570
        spacing: 10

        model:[
                            "International Date Line West", "Co-ordinated Universal Time-11", "Aleutian Islands, Hawaii", "Marquesas Islands", "Alaska, Co-ordinated Universal Time-09", "Baja California, Co-ordinated Universal Time-08, Pacific Time (US & Canada)", "Arizona, Chihuahua, La Paz, Mazatlan, Mountain Time (US & Canada)", "Central America, Central Time (US & Canada), Easter Island, Guadalajara, Mexico City, Monterrey, Saskatchewan", "Bogota, Lima, Quito, Rio Branco, Chetumal, Eastern Time (US & Canada), Haiti, Havana, Indiana (East), Turks and Caicos", "Asuncion, Atlantic Time (Canada), Caracas, Cuiaba, Georgetown, La Paz, Manaus, San Juan, Santiago"                                     ]

        delegate:
        Rectangle {
            id: rect
            height: 120
            width: listview.width
            color: "red"
            Text {
                id: selectedText

                width: listview.width
                color: "#000"

                font.pixelSize: 28

                text: modelData
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.centerIn: parent
                elide: Text.ElideRight
            }

            MouseArea {
                anchors.fill: parent
                onClicked: console.log(index)
            }
//            onYChanged: {
//                selectedText.font.pixelSize = ( y % 285 ) / 285 * 28
//            }

        }


    }
//        Image {
//            id: image
//            anchors.centerIn: parent
//            width: 100
//            height: 100
//            source: "qrc:/btn_circle_setting_line.svg"

//            SequentialAnimation {
//                id: anime
//                running: false
//                NumberAnimation {
//                    target: image
//                    property: "scale"
//                    from: 1
//                    to: 1.2
//                    duration: 100
//                    easing.type: Easing.InOutQuad
//                }
//                NumberAnimation {
//                    target: image
//                    property: "scale"
//                    from: 1.2
//                    to: 1
//                    duration: 100
//                    easing.type: Easing.InOutQuad
//                }
//            }
//            MouseArea {
//                anchors.fill: parent
//                onPressed: {

//                }

//                onReleased: {

//                }
//                onClicked: {
//                    anime.running = true
//                }
//            }
//        }

}
