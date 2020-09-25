#include "runnable.h"
#include "statescr.h"
#include <QDebug>

Runnable::Runnable(QObject *receiver):
          mReceiver(receiver),
          mRunning(false){}
void Runnable::run() {
    mRunning = true;
    while(mRunning){
        QDateTime dateTime = QDateTime::currentDateTime();
        QString dateTimeString = dateTime.toString();
        mDateTime = dateTimeString;
        QMetaObject::invokeMethod(mReceiver, "setDateTime",
                                  Qt::QueuedConnection,
                                  Q_ARG(QString, mDateTime));
        QThread::msleep(10);
    }
}

bool Runnable::isRunning() const{
    return mRunning;
}

void Runnable::stop() {
    mRunning = false;
}
