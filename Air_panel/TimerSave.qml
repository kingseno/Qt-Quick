import QtQuick 2.0
import BackEnd 1.0

Item {
    property string save: "6:0"
    property bool is_override: false

    function enablemain() {
        setting.enabled = true;
        buttonBar.enabled = true;
    }
    function saveconfig() {
           var fanlevel;
           switch(fanSpeed.value) {
           case 0:
               fanlevel = Custom.LEVEL1
               break;
           case 1:
               fanlevel = Custom.LEVEL2
               break;
           case 2:
               fanlevel = Custom.LEVEL2
               break;
           default:
                break;
           }
           var swing;
           switch(swingCtrl.value) {
           case 0:
               swing = Custom.UP
               break;
           case 1:
               swing = Custom.DOWN
               break;
           case 2:
               swing = Custom.AUTO
               break;
           default:
                break;
           }

           var timer_state;
           switch(alarmState.checked) {
           case false:
               timer_state = Custom.ALARM_OFF
               break;
           case true:
               timer_state = Custom.ALARM_ON
               break;
           default:
                break;
           }

           var mode;
           switch(modeCtrl.value) {
           case 0:
               mode = Custom.NORMAL;
               break;
           case 1:
               mode = Custom.FRESH;
               break;
           case 2:
               mode = Custom.DRY;
               break;
           default:
                break;
           }
             config.createConfigHandler(textEdit.text, sld.value, fanlevel, swingCtrl, timer.text, timer_state, mode);
       }

       function backmain() {
           textEdit.text= "";
           buttonBar.resSetting = true;
           setting.visible = false;
           panel.visible = true;
       }
       function txtConfig() {
           txtFan.text = (config.current_fanLevel == 0) ? "LOW" : (config.current_fanLevel == 1) ? "MEDIUM" : "HIGH";
       }
}
