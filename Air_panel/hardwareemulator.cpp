#include "hardwareemulator.h"
#include "QtDebug"


HardwareEmulator::HardwareEmulator(QObject *parent)
{
    Q_UNUSED(parent);
    m_timer.setInterval(1000);
}

bool HardwareEmulator::setState(CustomDefine::air_condition_state state)
{
    qDebug() << "Air condition state changed to:" << ( (state == CustomDefine::ON) ? "ON" : "OFF");
    return true;
}

bool HardwareEmulator::setTemperature(int temp)
{
    qDebug() << "Temperature changed to " << temp;
    return true;
}

bool HardwareEmulator::setMode(CustomDefine::air_condition_mode mode)
{
    QString strMode;
    switch (mode) {
    case CustomDefine::NORMAL:
        strMode = "NORMAL";
        break;
    case CustomDefine::DRY:
        strMode = "DRY";
        break;
    case CustomDefine::FRESH:
        strMode = "FRESH";
        break;
    }
    qDebug() << "Mode changed to: " << strMode;
    return true;
}

bool HardwareEmulator::setFan(CustomDefine::air_condition_fan level)
{
//    CustomDefine::air_condition_fan level = CustomDefine::LEVEL1;
    qDebug() << "OKOKOKOK";
    QString strLevel;
    switch (level) {
    case CustomDefine::LEVEL1:
        strLevel = "LEVEL1";
        break;
    case CustomDefine::LEVEL2:
        strLevel = "LEVEL2";
        break;
    case CustomDefine::LEVEL3:
        strLevel = "LEVEL3";
        break;
    }
    qDebug() << "Fan changed to: " << strLevel;
    return true;
}

bool HardwareEmulator::setAlarm(QString time, CustomDefine::air_condition_alarm_state state)
{
    if(state == CustomDefine::ALARM_OFF)
    {
       qDebug() << "Alarm OFF";
       disconnect(&m_timer, SIGNAL(timeout()), this, SLOT(timerTickHandler()));
       m_timer.stop();

    }
    else
    {
        m_alarm = QTime::fromString(time,"hh:mm");
        connect(&m_timer, SIGNAL(timeout()), this, SLOT(timerTickHandler()));
        m_timer.start();
    }

    return true;
}

bool HardwareEmulator::setSwing(CustomDefine::air_condition_swing swing)
{
    qDebug() << "swing changed: " << ((swing == CustomDefine::UP) ? "UP" : (swing == CustomDefine::DOWN) ? "DOWN" : "AUTO");
    return  true;
}

void HardwareEmulator::timerTickHandler()
{
    if( (m_alarm.hour() == QTime::currentTime().hour()) && (m_alarm.minute() == QTime::currentTime().minute()))
    {
        emit alarm();
        m_timer.stop();
        disconnect(&m_timer, SIGNAL(timeout()), this, SLOT(timerTickHandler()));
        qDebug() << "ALARM";
        this->setState(CustomDefine::OFF);

    }
}

