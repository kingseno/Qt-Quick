#ifndef CUSTOMDEFINE_H
#define CUSTOMDEFINE_H
#include <QObject>


class CustomDefine : public QObject
{
    Q_OBJECT

public:
    CustomDefine(): QObject() {};
    enum air_condition_state {ON,OFF};
    enum air_condition_alarm_state {ALARM_ON,ALARM_OFF};
    enum air_condition_mode  {NORMAL, DRY, FRESH};
    enum air_condition_swing {UP,DOWN,AUTO};
    enum air_condition_fan   {LEVEL1, LEVEL2, LEVEL3};

    Q_ENUMS(air_condition_state)
    Q_ENUMS(air_condition_alarm_state)
    Q_ENUMS(air_condition_mode)
    Q_ENUMS(air_condition_swing)
    Q_ENUMS(air_condition_fan)

};
#endif // CUSTOMDEFINE_H
