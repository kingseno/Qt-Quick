#include "configuration.h"

Configuration::Configuration(QObject *parent) : QObject(parent)
{
    m_infoAlarm = 0;
}

int Configuration::infoAlarm() const {
    return m_infoAlarm;
}

void Configuration::setInfoAlarm(const int &infoAlarm) {
    if (infoAlarm != m_infoAlarm) {
        m_infoAlarm = infoAlarm;
        emit infoAlarmChanged();
    }
}

void Configuration::saveChanges (QVariantMap alarmMap) {
//    qDebug() << alarmMap.value("daysToRepeat").toJsonObject().value("dayOfWeek").toString();
        //qDebug() << alarmMap.value("hour").toString();
    qDebug() << alarmMap;
}

void Configuration::loadAlarms () {

}

void Configuration::confirmStatusOfChanges() {

}

