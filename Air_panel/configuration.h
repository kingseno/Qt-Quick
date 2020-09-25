#ifndef Configuration_H
#define Configuration_H

#include <QObject>
#include <QFile>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QJsonObject>
#include "CustomDefine.h"
class Configuration : public QObject
{
    Q_OBJECT
    Q_ENUMS(CustomDefine::air_condition_fan)
    Q_ENUMS(CustomDefine::air_condition_swing)
    Q_ENUMS(CustomDefine::air_condition_alarm_state)
    Q_ENUMS(CustomDefine::air_condition_mode)

    Q_PROPERTY(QStringList current_listConfigName READ current_listConfigName NOTIFY listConfigNameChanged )
    Q_PROPERTY(QString current_configName READ current_configName NOTIFY configNameChanged )
    Q_PROPERTY(int current_temperature READ current_temperature NOTIFY temperatureChanged)
    Q_PROPERTY(CustomDefine::air_condition_fan current_fanLevel READ current_fanLevel NOTIFY fanLevelChanged)
    Q_PROPERTY(CustomDefine::air_condition_swing current_swing READ current_swing NOTIFY swingChanged)
    Q_PROPERTY(QString current_alarm READ current_alarm NOTIFY alarmChanged)
    Q_PROPERTY(CustomDefine::air_condition_alarm_state current_alarmState READ current_alarmState NOTIFY alarmStateChanged )
    Q_PROPERTY(CustomDefine::air_condition_mode current_operationMode READ current_operationMode NOTIFY operationModeChanged)

public:
    explicit Configuration(QObject *parent = nullptr);
    //getter
    QStringList current_listConfigName() const  {return m_listConfigName;};
    QString current_configName() const  {return  m_configName;} ;
    int current_temperature() const {return  m_temperature;};
    CustomDefine::air_condition_fan current_fanLevel() const  {return  m_fanLevel;};
    CustomDefine::air_condition_swing current_swing()  const {return m_swing;};
    QString current_alarm() const {return m_alarm;};
    CustomDefine::air_condition_alarm_state current_alarmState() const  {return m_alarmState;};
    CustomDefine::air_condition_mode current_operationMode() const  {return  m_operationMode;};

signals:
    void listConfigNameChanged(QStringList);
    void configNameChanged(QString);
    void temperatureChanged(int);
    void fanLevelChanged(CustomDefine::air_condition_fan);
    void swingChanged(CustomDefine::air_condition_swing);
    void alarmChanged(QString);
    void alarmStateChanged(CustomDefine::air_condition_alarm_state);
    void operationModeChanged(CustomDefine::air_condition_mode);

public slots:
    /*
     createConfigHandler
     When user want to save current state of air condition, UI
     need to emit signal consit {name,temperature, fan level,swing,time, operation mode } ,
     then createConfigHandler will save data to json file, and apply this configure
    */
    void createConfigHandler(QString configName,
                             int temp,
                             CustomDefine::air_condition_fan fanLevel,
                             CustomDefine::air_condition_swing swing,
                             QString alarm,
                             CustomDefine::air_condition_alarm_state alarmState,
                             CustomDefine::air_condition_mode operationMode);
    /*
     loadConfigHandler
     When user select config, UI emit signal consit name of config then
     configuration class load all properies (temp, fan,...) base on name of config
    */
    void loadConfigHandler(QString name);


private:
    void loadListConfig();
    void checkConfiguration();
    void createConfig(QString configName,
                      int temp,
                      CustomDefine::air_condition_fan fanLevel,
                      CustomDefine::air_condition_swing swing,
                      QString alarm,
                      CustomDefine::air_condition_alarm_state alarmState,
                      CustomDefine::air_condition_mode operationMode);
    void overWriteConfig(QString configName,
                      int temp,
                      CustomDefine::air_condition_fan fanLevel,
                      CustomDefine::air_condition_swing swing,
                      QString alarm,
                      CustomDefine::air_condition_alarm_state alarmState,
                      CustomDefine::air_condition_mode operationMode);


    QStringList m_listConfigName;

    QString m_configName;
    int m_temperature;
    CustomDefine::air_condition_fan m_fanLevel;
    CustomDefine::air_condition_swing m_swing;
    QString m_alarm;
    CustomDefine::air_condition_alarm_state m_alarmState;
    CustomDefine::air_condition_mode m_operationMode;

};

#endif // Configuration_H
