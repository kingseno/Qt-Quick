#include "data.h"

Data::Data(QObject *parent):QObject(parent) {
    m_dateTime = "123";
    runnable = new Runnable(this);
}

Data::~Data() {
    runnable->stop();
}

void Data::currentDateTime() {
    if(!runnable->isRunning())
        QThreadPool::globalInstance()->start(runnable);
}

QString Data::dateTime() const{
    return m_dateTime;
}

void Data::setDateTime(QString const& dateTime) {
    if(m_dateTime == dateTime)
        return;
    m_dateTime = dateTime;
    emit dateTimeChanged(m_dateTime);
}
