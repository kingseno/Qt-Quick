import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

Item {
    id: transactionAddScreen

    Component.onCompleted: {
        root.addButtonCheck = false
    }

    property url iconType: "qrc:/icon/icon/underline.svg"

    ColumnLayout {
        width: root.width
        anchors.margins: 5

        RowLayout {
            id: layoutTransactionMoney
            Layout.alignment: Qt.AlignTop

            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.topMargin: 10
            //Layout.bottomMargin: 5
            spacing: 10

            Label {
                text: "Money"
                font.pixelSize: 16
            }

            TextField {
                id: inputMoney
                Layout.fillWidth: true
                placeholderText: qsTr("0")
                //text: "Enter name..."
                font.pixelSize: 20
                color: "green"
                focus: true
                activeFocusOnTab: true

                onEditingFinished: {
                    root.newMoney = parseInt(inputMoney.text)
                    console.log(inputMoney.text)
                }
            }
        }

        RowLayout {
            id: layoutTransactionNote
            //Layout.alignment: Qt.AlignTop

            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.topMargin: 5
            Layout.bottomMargin: 10
            spacing: 30

            Image {
                source: "qrc:/icon/icon/align-left.svg"
                opacity: 0.5
            }

            TextField {
                id: inputNote
                Layout.fillWidth: true
                placeholderText: qsTr("")
                text: ""
                font.pixelSize: 20
                color: "green"
                focus: true
                activeFocusOnTab: true

                onEditingFinished: {
                    root.newNote = inputNote.text
                }
            }
        }

        //        RowLayout {
        //            id: layoutTransactionDate
        //            //Layout.alignment: Qt.AlignTop

        //            Layout.leftMargin: 10
        //            Layout.rightMargin: 10
        //            Layout.topMargin: 10
        //            Layout.bottomMargin: 10
        //            spacing: 30

        //            property var pickDate: 1
        //            property var pickMonth: "Jan"
        //            property var pickYear: 2020

        //            Image {
        //                id: label_date
        //                source: "qrc:/icon/icon/calendar.svg"
        //                opacity: 0.5
        //            }

        //            Rectangle {
        //                id: inputDate
        //                Layout.fillWidth: true
        //                height: 30
        ////                border.color: "black"
        ////                border.width: 1

        //                Text {
        //                    //text:
        //                    font.pixelSize: 20
        //                    color: "green"
        //                    focus: true
        //                    activeFocusOnTab: true
        //                }

        //                MouseArea {
        //                    anchors.fill: parent
        //                    onClicked: {
        //                        modelDialog.open();
        //                    }
        //                }
        //            }

        //            ModelDialogDate {
        //                id: modelDialog
        //                x: Math.round((parent.width - width) / 2)
        //                y: Math.round((parent.height - height) / 2)
        //            }
        //        }

        RowLayout {
            id: layoutTransactionType

            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            spacing: 26

            Image {
                id: label_type
                source: iconType
                opacity: 0.5
            }
            ComboBox {
                id: boxType
                width: 200
                model: ["Food", "Bills", "Shopping", "Vehicle", "Health", "Others"]

                onActivated: {
                    funcIconSelect(boxType.currentText);
                    root.newType = boxType.currentText
                    root.newIconType = iconType
                }
            }
        }

        RowLayout {
            id: layoutTransactionMode

            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            spacing: 26

            RadioButton {
                checked: true
                text: qsTr("Income")
            }
            RadioButton {
                checked: false
                text: qsTr("Expense")
            }
        }
    }

    //function to check a string is a number or not
    function isNumeric(num){
        return !isNaN(num)
    }

    function funcIconSelect(text){
        switch(text) {
            case "Food":
                iconType = "qrc:/icon/icon/underline.svg"
                break;
            case "Bills":
                iconType = "qrc:/icon/icon/book.svg"
                break;
            case "Shopping":
                iconType = "qrc:/icon/icon/shopping-cart.svg"
                break;
            case "Vehicle":
                iconType = "qrc:/icon/icon/truck.svg"
                break;
            case "Health":
                iconType = "qrc:/icon/icon/heart.svg"
                break;
            case "Others":
            default:
                iconType = "qrc:/icon/icon/help_circle.svg"
                break;
        }


    }

}
