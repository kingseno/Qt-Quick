#ifndef RUNNABLE_H
#define RUNNABLE_H
#include <QObject>
#include <QRunnable>
#include <QThread>
#include <QDateTime>

class Runnable: public QRunnable
{
public:
    Runnable(QObject*);
    void run();
    bool isRunning() const;
    void stop();
private:
    QString mDateTime;
    QObject *mReceiver;
    bool mRunning;
};

#endif // RUNNABLE_H
