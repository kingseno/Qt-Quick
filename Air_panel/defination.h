#ifndef DEFINATION_H
#define DEFINATION_H
enum air_condition_state            {ON,OFF};
enum air_condition_alarm_state      {ALARM_ON,ALARM_OFF};
enum air_condition_mode             {NORMAL, DRY, FRESH};
enum air_condition_swing            {UP,DOWN,AUTO};
enum air_condition_fan              {LEVEL1, LEVEL2, LEVEL3};
#define CONFIG_PATH "./config.json"
#endif // DEFINATION_H
