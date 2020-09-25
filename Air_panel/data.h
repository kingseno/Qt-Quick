#ifndef DATA_H
#define DATA_H
#include <QObject>
#include <QThreadPool>
#include "runnable.h"

class Data: public QObject {
    Q_OBJECT
    Q_PROPERTY(QString dateTime READ dateTime WRITE setDateTime NOTIFY dateTimeChanged)
public:
    explicit Data(QObject *parent = nullptr);
    ~Data();
    Q_INVOKABLE void currentDateTime();
    QString dateTime() const;
public slots:
    void setDateTime(QString const&);
signals:
    void dateTimeChanged(QString);
private:
    QString m_dateTime;
    Runnable *runnable;
};

#endif // DATA_H
