#ifndef HARDWAREEMULATOR_H
#define HARDWAREEMULATOR_H

#include <QObject>
#include <QDebug>
#include <QTime>
#include <QTimer>
#include "CustomDefine.h"
class HardwareEmulator : public QObject
{
    Q_OBJECT
    Q_ENUMS(CustomDefine::air_condition_state)
    Q_ENUMS(CustomDefine::air_condition_mode)
    Q_ENUMS(CustomDefine::air_condition_fan)
    Q_ENUMS(CustomDefine::air_condition_alarm_state)
    Q_ENUMS(CustomDefine::air_condition_swing)

public:
    explicit HardwareEmulator(QObject *parent = nullptr);

    Q_INVOKABLE bool setState(CustomDefine::air_condition_state state);
    Q_INVOKABLE bool setTemperature(int temp);
    Q_INVOKABLE bool setMode(CustomDefine::air_condition_mode mode);
    Q_INVOKABLE bool setFan(CustomDefine::air_condition_fan);
    Q_INVOKABLE bool setAlarm(QString time, CustomDefine::air_condition_alarm_state state);
    Q_INVOKABLE bool setSwing(CustomDefine::air_condition_swing swing);
signals:
    void alarm();
public slots:
    void timerTickHandler();
private:
    QTime m_alarm;
    QTimer m_timer;
};

#endif // HARDWAREEMULATOR_H
