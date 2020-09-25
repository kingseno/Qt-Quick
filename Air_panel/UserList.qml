import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.14
import BackEnd 1.0

Rectangle {
    id:listElement
    visible: false;
    width: 490
    height: 325
    anchors.margins: 5
    antialiasing: true
    border.color: "black"
    radius: 10
    gradient: Gradient {
        GradientStop { position: 0.0; color: "gray" }
        GradientStop { position: 1.0; color: "white" }
    }
    ListModel {
        id: model
    }

    Component {
        id: delegate
        Rectangle {
            id: rec
            width: 470
            height: 40
            radius: 10
            Text {
                    text:  name;
                    anchors.centerIn: parent
                    font.pixelSize: 20
                }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                {
                    rec.color = "#b0c4de"
                    rec.opacity = 0.5
                }
                onExited:
                {
                    rec.color = "white"
                    rec.opacity = 1
                }
                onClicked: {
                    // load config
                    console.log("clicked")
                    config.loadConfigHandler(name)
                    // emit signal to HW
                    hardware.setTemperature(config.current_temperature)
                    hardware.setFan(config.current_fanLevel)
                    hardware.setSwing(config.current_swing)
                    hardware.setAlarm(config.current_alarm,config.current_alarmState)
                    hardware.setMode(config.current_operationMode)
                    // get info main
                    txtFan.text = (config.current_fanLevel === Custom.LEVEL1) ? "LOW" : (config.current_fanLevel === Custom.LEVEL2) ? "MEDIUM" : "HIGH";
                    txtMode.text = (config.current_operationMode === Custom.NORMAL) ? "NORMAL" : (config.current_operationMode === Custom.FRESH) ? "FRESH" : "DRY";
                    txtSwing.text = (config.current_swing === Custom.UP) ? "UP" : (config.current_swing === Custom.DOWN) ? "DOWN" : "AUTO";
                    txtAlarmState.text = (config.current_alarmState === Custom.OFF) ? "ON" : "OFF";
                    txtTimer.text = config.current_alarm;
                    txtTemp.text = config.current_temperature;
                    setting.matchSettingConfig()
                    // exit
                    buttonBar.scrUserList()
                    //tbd
                }
            }
        }

    }

    ListView {
        model: model
        delegate: delegate
        anchors.fill: parent
        spacing: 10
        anchors.margins: 10
        anchors.bottomMargin: 45
        anchors.topMargin: 35
        onVisibleChanged: {
                function checkContains(model, name) {
                  for(var i = 0; i < model.count; i++)
                      if (model.get(i).name === name)
                            return true
                  return false
                }
        function appendToListModel(item, index){
            if(!checkContains(model,item))
                model.append({"name":item})
        }
        config.current_listConfigName.forEach(appendToListModel)

    }
   }
}
