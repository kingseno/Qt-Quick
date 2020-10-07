import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ColumnLayout {
        spacing: 10
        anchors.fill: parent

        SpinBox {
            Layout.alignment: Qt.AlignHCenter
            from: 0
            to: items.length - 1
            value: 1 // "Medium"

            property var items: ["Small", "Medium", "Large"]

            textFromValue: function(value) {
                return items[value];
            }

            valueFromText: function(text) {
                for (var i = 0; i < items.length; ++i) {
                    if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                        return i
                }
                return sb.value
            }
        }

        ComboBox {
            Layout.alignment: Qt.AlignHCenter
            editable: true
            model: ListModel {
                id: model
                ListElement { text: "Banana" }
                ListElement { text: "Apple" }
                ListElement { text: "Coconut" }
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Switch {
                text: qsTr("Wi-Fi")
            }
            Switch {
                text: qsTr("Bluetooth")
            }
        }

        Dial {
            Layout.alignment: Qt.AlignHCenter
            from: 0
            to: 360
            stepSize: 1
            value: 0
        }

    }

}
