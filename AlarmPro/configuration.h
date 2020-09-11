#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <QFile>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QJsonObject>
#include <iostream>
#include <vector>
using namespace std;

class Configuration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int infoAlarm READ infoAlarm WRITE setInfoAlarm NOTIFY infoAlarmChanged)
public:
    explicit Configuration(QObject *parent = nullptr);

    int infoAlarm() const;
    void setInfoAlarm(const int &infoAlarm);

signals:
    void infoAlarmChanged();

public slots:
    void saveChanges(QVariantMap alarmMap[]);
    void loadAlarms();

private:
    int m_infoAlarm;
};




#endif // CONFIGURATION_H
