import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Dialog {
        id: dialog
        title: "Demo dialog"
        width: parent.width * 0.8
        anchors.centerIn: parent
        modal: true
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

        function formatNumber(number) {
            return number < 10 && number >= 0 ? "0" + number : number.toString()
        }

        onRejected: dialog.close()

        contentItem: ColumnLayout {
            width: parent.width

            RowLayout {
                id: rowTumbler
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 40

                Tumbler {
                    id: hoursTumbler
                    model: 24
                    delegate: TumblerDelegate {
                        text: dialog.formatNumber(modelData)
                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                    }
                }
                Text {
                    text: qsTr(":")
                    color: "black"
                }
                Tumbler {
                    id: minutesTumbler
                    model: 60
                    delegate: TumblerDelegate {
                        text: dialog.formatNumber(modelData)
                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                    }
                }
            }

            TextField {
                id: descriptionTextField
                Layout.fillWidth: true
                placeholderText: qsTr("Enter description here")
                text: ""
            }

        }
    }

    Component.onCompleted: dialog.open()
}
