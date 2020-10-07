import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr("‹")
                font.pixelSize: 20
                onClicked: stack.pop() // get the current page out the stack
            }
            Label {
                text: "Title"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: fisrtPage
    }

    Component {
        id: fisrtPage
        FirstPage {} // if you want to call like this, you must create a .qml file which has the same name
    }

    Component {
        id: secondPage
        SecondPage {}
    }

    Component {
        id: thirdPage
        ThirdPage {}
    }


    function loadPage(page) { // you can define a funtion in a element, and in this function you can write js code
        switch (page) {
        case 'Page1':
            stack.push(fisrtPage); // push this page into the stack and display it
            break;
        case 'Page2':
            stack.push(secondPage);
            break;
        case 'Page3':
            stack.push(thirdPage);
            break;
        }
    }
}
