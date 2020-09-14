#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <QFile>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QJsonObject>

class Configuration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int infoAlarm READ infoAlarm WRITE setInfoAlarm NOTIFY infoAlarmChanged)
public:
    explicit Configuration (QObject *parent = nullptr);

    int infoAlarm () const;
    void setInfoAlarm (const int &infoAlarm);

signals:
    void infoAlarmChanged ();

public slots:
    void saveChanges (QVariantList alarmInfo);
    QJsonObject loadAlarms ();

private:
    int m_infoAlarm;
    void checkConfiguration();
};




#endif // CONFIGURATION_H
