#ifndef MYTIMER_H
#define MYTIMER_H

#include <QObject>
#include <QElapsedTimer>

class MyTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int elapsed MEMBER m_elapsed NOTIFY elapsedChanged)
    Q_PROPERTY(bool running MEMBER m_running NOTIFY runningChanged)
public:
    explicit MyTimer(QObject *parent = nullptr);

private:
    QElapsedTimer m_timer;
    int m_elapsed;
    bool m_running;
public slots:
    void start();
    void stop();

signals:
    void runningChanged();
    void elapsedChanged();

};

#endif // MYTIMER_H
