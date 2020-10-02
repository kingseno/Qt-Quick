import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.calendar 1.0

ApplicationWindow {
    id: root
    width: 9*sizeScreen
    height: 18*sizeScreen
    visible: true
    title: qsTr("Money")

    readonly property int sizeScreen: 35

    property var headerSelect: "▼"
    property string headerName: "Money Saving"
    property var headerMenu: "☰"

    property bool addButtonCheck: true
    property url avatarImage: "qrc:/icon/icon/bank_icon.png"

    property int newMoney: 0
    property string newType: "Food"
    property string newNote: ""
    property var newIconType: "qrc:/icon/icon/underline.svg"

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: headerSelect
                onClicked: {
                    headerSelect = "▼"
                    headerName = "Money Saving"
                    headerMenu = "☰"
                    addButtonCheck = true
                    stackView.pop()
                }
            }
            Label {
                text: headerName
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                text: headerMenu
                onClicked: {
                    bikeList.append({
                                        "label": newMoney + " đ",
                                        "type": newType,
                                        "note": newNote,
                                        "url": newIconType
                                    })
                    headerSelect = "▼"
                    headerName = "Money Saving"
                    headerMenu = "☰"
                    addButtonCheck = true
                    stackView.pop()
                }
            }
        }
    }

    StackView {
        id: stackView

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: header.bottom
        }
        initialItem: ListView {
            id: moneyView
            model: ModelMoney { id: bikeList }
            delegate: ModelDelegate {
                Component.onCompleted: {
                    headerName = "Money Saving"
                    headerMenu = "☰"
                }
            }
        }
    }

    RowLayout {
        id: footerButton
        width: parent.width

        anchors.bottom: parent.bottom
        anchors.leftMargin: 40

        RoundButton {
            id: transactionScreen
            visible: addButtonCheck

//            anchors {
//                bottom: parent.bottom
//                bottomMargin: 20
//                //left: parent.left
//            }

            Image {
                anchors.fill: parent
                source: "qrc:/icon/icon/home.svg"
                scale: 0.5
            }
        }

        RoundButton {
            id: addBikeId
            text: "+"
//            anchors {
//                bottom: parent.bottom
//                bottomMargin: 20
//                //horizontalCenter: parent.horizontalCenter
//            }
            visible: addButtonCheck
            onClicked: {
                stackView.pop();
                stackView.push(addBikePage);
            }
        }

        RoundButton {
            id: resultScreen
            visible: addButtonCheck

//            anchors {
//                bottom: parent.bottom
//                bottomMargin: 20
//                //left: parent.left
//            }

            Image {
                anchors.fill: parent
                source: "qrc:/icon/icon/bar-chart-2.svg"
                scale: 0.5
            }
        }
    }

    Component {
        id: addBikePage
        ModelAdd {
            Component.onCompleted: {
                headerSelect = "✕"
                headerName = "Add transaction"
                headerMenu = "OK"
            }
        }
    }
}
