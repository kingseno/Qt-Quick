import QtQuick 2.0
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.4
import BackEnd 1.0

RowLayout {
    id: buttonBar
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 120
//    property HandleKey handleKey: null

    RoundButton {
        onClicked: handleKeyPower()
        Image {
            sourceSize.width: 40
            sourceSize.height: 40
            source: "qrc:/images/power"
        }
    }
    RoundButton {
        id: btnAdd
        enabled: true
        text: "▲"
        font.pixelSize: 20
        font.bold: true
        onClicked: handleKeyUp()
    }
    RoundButton {
        id: btnSub
        enabled: true
        text: "▼"
        font.pixelSize: 20
        font.bold: true
        onClicked:handleKeyDown()
    }
    RoundButton {
        onClicked: scrSettinng()
        Image {
            sourceSize.width: 40
            sourceSize.height: 40
            source: "qrc:/images/setting"
        }
    }
    RoundButton {
        text: "AUTO"
        onClicked: scrUserList()
        font.pixelSize: 20
        font.bold: true
    }
    property bool resSetting : true
    property bool resUser: true
    function scrSettinng() {
        btnAdd.enabled = true;
        btnSub.enabled  = true;
        resUser = true;
        setting.setTempSlider(txtTemp.text);
        if (resSetting) {
            userList.visible = false;
            setting.visible = true;
            panel.visible = false;
            resSetting = false;
        } else {
            userList.visible = false;
            setting.visible = false;
            panel.visible = true;
            resSetting = true;
        }
        handleKey.handleKeySetting()
    }

    function scrUserList() {
        resSetting = true;
        if (resUser) {
            setting.visible = false;
            panel.visible = false;
            userList.visible = true;
            btnAdd.enabled = false;
            btnSub.enabled  = false;
            resUser = false;
            resPW = !resPW;
        } else {
            setting.visible = false;
            panel.visible = true;
            userList.visible = false;
            btnAdd.enabled = true;
            btnSub.enabled  = true;
            resUser = true;
            resPW = !resPW;
        }

        handleKey.handleKeyAuto();
    }
    property bool resPW: true;
    function handleKeyPower() {
        resSetting = true;
        resUser = true;
        setting.visible = false;
        panel.visible = true;
        userList.visible = false;
        resSetting = true;
        if (resPW) {
            resPW = false;
            resUser = !resUser;
            txtPOWER.text ="ON";
        } else {
            resPW = true;
            txtPOWER.text ="OFF";
            resUser = !resUser;

        }
    }
    function handleKeyUp() {
        if (txtTemp.text >= 15 && txtTemp.text <= 34) {
            var couter = ++txtTemp.text ;
            setting.setTempSlider(couter);
            hardware.setTemperature(couter);
        }
    }
    function handleKeyDown() {
        if (txtTemp.text > 15 && txtTemp.text <= 35) {
            var couter =  --txtTemp.text;
            setting.setTempSlider(couter);
            hardware.setTemperature(couter);
        }
    }
}
