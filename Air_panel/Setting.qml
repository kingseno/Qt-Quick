import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.14
import BackEnd 1.0

Rectangle {
    id: setting
    visible: false;
    width: 490
    height: 325
    anchors.margins: 5
    antialiasing: true
    border.color: "black"
    radius: 10
    property var itemsFan: ["LOW", "MEDIUM", "HIGH"]
    property var itemsSwing: ["UP", "DOWN", "AUTO"]
    property var itemsMode: ["NORMAL", "FRESH", "DRY"]

    gradient: Gradient {
        GradientStop { position: 0.0; color: "gray" }
        GradientStop { position: 1.0; color: "white" }
    }

    Text{
        id: warning
        text: "Fill name"
        font.pixelSize : 15
        x: 400
        y: 20
        visible: false
        color:  "Red"
    }

    TimerSave{
        id: savetime
    }

    Column
    {
        y:15
        x:20
        spacing: 2
        RowLayout {
        spacing: 1
            Text {
                text:qsTr("Mode Name: ")
                font.pixelSize : 20
            }
            TextInput {
                maximumLength: 20
                id: textEdit
                    width: 250
                    height: 50
                    font.pixelSize : 20
                    property string placeholderText: "Enter mode name here..."
                    Text {
                        text: textEdit.placeholderText
                        color: "white"
                        visible: !textEdit.text
                        font.pixelSize : 20
                    }
            }
        }

        RowLayout {
            Text {
                text:qsTr("Temperature: ")
                font.pixelSize : 20
            }
            Slider {
                id:sld
                from: 15
                value: txtTemp.text;
                to: 35
                stepSize: 1
                snapMode: Slider.SnapAlways;
            }
            Text {
                text: sld.value
                font.pixelSize : 15
            }
        }
        RowLayout {
            height: 40
            Text {
                text:qsTr("FAN speed: ")
                font.pixelSize : 20
            }
            Rectangle{
                x: 170
                SpinBox {
                    id:fanSpeed
                    from: 0
                    to: itemsFan.length - 1
                    value: 1 // "Medium"

                    textFromValue: function(value) {
                        return itemsFan[value];
                    }

                    valueFromText: function(text) {
                        for (var i = 0; i < itemsFan.length; ++i) {
                            if (itemsFan[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                }
            }
         }
        RowLayout {
            height: 40
            Text {
                text:qsTr("Swing: ")
                font.pixelSize : 20
            }
            Rectangle{
                x: 170
                SpinBox {
                    id: swingCtrl
                    from: 0
                    to: itemsSwing.length - 1
                    value: 2 // "AUTO"
                    textFromValue: function(value) {
                        return itemsSwing[value];
                    }

                    valueFromText: function(text) {
                        for (var i = 0; i < itemsSwing.length; ++i) {
                            if (itemsSwing[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                }
            }
         }
        RowLayout {
            height: 40
            Text {
                text:qsTr("Operation mode: ")
                font.pixelSize : 20
            }
            Rectangle{
                x: 170
                SpinBox {
                    id: modeCtrl
                    from: 0
                    to: itemsMode.length - 1
                    value: 0 // "AUTO"

                    textFromValue: function(value) {
                        return itemsMode[value];
                    }

                    valueFromText: function(text) {
                        for (var i = 0; i < itemsMode.length; ++i) {
                            if (itemsMode[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                }
            }
         }
        RowLayout {
            Text {
                text:qsTr("Alarm state: ")
                font.pixelSize : 20
            }
            Switch {
                id: alarmState
                checked: false
            }
        }
        RowLayout {
            spacing: 20
            Text {
                text:qsTr("Timer: ")
                font.pixelSize : 20
            }
            Text {
                id:timer
                text: savetime.save
                font.pixelSize : 20
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        timePicker.visible = true;
                        setting.enabled = false;
                        buttonBar.enabled = false;
                    }
                }
                TimePicker {
                    id: timePicker
                    visible: false;
                    target: savetime
                }

            }
        }
       RowLayout {
           x:65
           spacing: 20
           height: 15
           Button {
               text: "OK"
               font.pixelSize: 20
               palette {
                   button: "#fbf2d4"
               }
               onClicked: btnOK()
               function btnOK() {
                   buttonBar.resSetting = true;
                   textEdit.text = "";
                   userList.visible = false;
                   setting.visible = false;
                   panel.visible = true;
                   hardware.setTemperature(sld.value);
                   txtTemp.text = sld.value;
                   var defineFan = Custom.LEVEL2;
                   var defineSwing = Custom.AUTO;
                   var defineMode = Custom.NORMAL;

                   // set speed fan
                   if (fanSpeed.value === 0) {
                       defineFan = Custom.LEVEL1;
                   } else if (fanSpeed === 1) {
                       defineFan = Custom.LEVEL2;
                   } else {
                       defineFan = Custom.LEVEL3
                   }
                   if (hardware.setFan(defineFan)) {
                       txtFan.text = itemsFan[fanSpeed.value];
                   }
                   else {
                       txtFan.text = "ERROR";
                   }
                   // set defineSwing
                    if (swingCtrl.value === 0) {
                        defineSwing = Custom.UP;
                    } else if (swingCtrl === 1) {
                        defineSwing = Custom.DOWN;
                    } else {
                        defineSwing = Custom.AUTO;
                    }
                    if (hardware.setSwing(defineSwing)) {
                        txtSwing.text = itemsSwing[swingCtrl.value]
                    }
                    else {
                        txtSwing.text = "ERROR";
                    }
                    // set defineMode
                    if (modeCtrl.value === 0) {
                        defineMode = Custom.NORMAL;
                    } else if (modeCtrl === 1) {
                        defineMode = Custom.DRY;
                    } else {
                        defineMode = Custom.FRESH;
                    }
                    if (hardware.setMode(defineMode)) {
                        txtMode.text = itemsMode[modeCtrl.value];
                    }
                    else {
                        txtMode.text = "ERROR";
                    }
                    // set alarm state
                    console.log(alarmState.checked)
                    if (alarmState.checked) {
                        hardware.setAlarm(savetime.save,Custom.ALARM_ON);
                        txtTimer.text = timer.text;
                        txtAlarmState.text = "ON"
                    } else {
                        hardware.setAlarm(savetime.save,Custom.ALARM_OFF);
                        txtTimer.text = timer.text;
                        txtAlarmState.text = "OFF"
                    }

                    // set temperature
                    if(hardware.setTemperature(sld.value)) {

                    }
               }
           }
           Button {
               text: "Save"
               font.pixelSize: 20
               palette {
                   button: "#fbf2d4"
               }
               ConfigSave{
                   id: configqs
                   visible : false;
                   target: savetime
               }

               onClicked: btnSave()
               function btnSave() {
//                   userList.visible = false;
                   if(textEdit.text == "") {
                       warning.visible = true;
                       return;
                   }
                   warning.visible = false;
                   var list = config.current_listConfigName;
                   console.log(list);
                   if(list.includes(textEdit.text)) {
                       configqs.visible = true;
                       setting.enabled = false;
                       buttonBar.enabled = false;
                   }
                   else {
                       savetime.saveconfig();
                   }
                   buttonBar.resSetting = true;
               }
           }
           Button {
               text: "Cancel"
               font.pixelSize: 20
               palette {
                   button: "#fbf2d4"
               }
               onClicked: btnCanel()
               function btnCanel() {
                   userList.visible = false;
                   setting.visible = false;
                   panel.visible = true;
                   buttonBar.resSetting = true;
               }
           }
       }
    }
    function setTempSlider(temp) {
        sld.value = temp;
    }
    function matchSettingConfig() {
        fanSpeed.value = config.current_fanLevel;
        modeCtrl.value = config.current_operationMode;
        swingCtrl.value = config.current_swing;
        sld.value = config.current_temperature;
        alarmState.checked =(txtAlarmState.text === "ON") ? true : false;
        savetime.save = config.current_alarm;
        textEdit.text = config.current_configName;
    }
}

