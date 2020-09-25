#include "configuration.h"
#include <QDebug>
#include <QJsonArray>
#define CONFIG_PATH "./config.json"

Configuration::Configuration(QObject *parent) : QObject(parent)
{
    checkConfiguration();
    loadListConfig();
    loadConfigHandler("default");
}

void Configuration::createConfigHandler(QString configName,
                                         int temp,
                                         CustomDefine::air_condition_fan fanLevel,
                                         CustomDefine::air_condition_swing swing,
                                         QString alarm,
                                         CustomDefine::air_condition_alarm_state alarmState,
                                         CustomDefine::air_condition_mode operationMode)
{
    // update current config
    this->m_configName = configName;
    this->m_temperature = temp;
    this->m_fanLevel = fanLevel;
    this->m_swing = swing;
    this->m_alarm = alarm;
    this->m_alarmState = alarmState;
    this->m_operationMode = operationMode;

    if(!m_listConfigName.contains(configName))
    {
        //create and save config to json
        createConfig( configName,temp,fanLevel,swing, alarm,alarmState ,operationMode);
        // update list_configurename
        m_listConfigName.append( configName);
        emit listConfigNameChanged(m_listConfigName);
    }
    else
    {
        overWriteConfig(configName,temp,fanLevel,swing, alarm,alarmState ,operationMode);
    }
}

void Configuration::loadListConfig()
{
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text)){
        // load configuration file
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();

        m_listConfigName.clear();

        for (int i=0;i<configJsonArr.count();i++)
        {
            m_listConfigName.append(configJsonArr.at(i).toObject()["name"].toString());
        }
        file.close();
    }
    emit listConfigNameChanged(m_listConfigName);
}

void Configuration::loadConfigHandler(QString name)
{
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text)){
        // load old config from file
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();

        for (int i=0;i<configJsonArr.count();i++){
            if(configJsonArr.at(i).toObject()["name"] == name){
                int temp = configJsonArr.at(i).toObject()["temperature"].toInt();
                int m_fan = configJsonArr.at(i).toObject()["fan level"].toInt();
                CustomDefine::air_condition_fan fan;
                fan = (m_fan == 1 ? CustomDefine::LEVEL1 :
                       m_fan == 2 ? CustomDefine::LEVEL2 :
                                    CustomDefine::LEVEL3);

                int m_swing = configJsonArr.at(i).toObject()["swing"].toInt();
                CustomDefine::air_condition_swing swing;
                swing = (m_swing == 0 ? CustomDefine::UP    :
                         m_swing == 1 ? CustomDefine::DOWN  :
                                        CustomDefine::AUTO);

                QString alarm = configJsonArr.at(i).toObject()["alarm"].toString();

                QString m_alarm_state = configJsonArr.at(i).toObject()["alarm state"].toString();

                CustomDefine::air_condition_alarm_state alarm_state;
                alarm_state = (QString::compare(m_alarm_state,"ON") ?  CustomDefine::ALARM_ON :
                                                                       CustomDefine::ALARM_OFF);

                int  m_operationMode = configJsonArr.at(i).toObject()["operation mode"].toInt();
                CustomDefine::air_condition_mode  operationMode;
                operationMode = (m_operationMode == 1 ? CustomDefine::NORMAL    :
                                 m_operationMode == 2 ? CustomDefine::FRESH     :
                                                        CustomDefine::DRY);

                // update current config
                this->m_configName = name;
                this->m_temperature = temp;
                this->m_fanLevel = fan;
                this->m_swing = swing;
                this->m_alarm = alarm;
                this->m_alarmState = alarm_state;
                this->m_operationMode = operationMode;
                // emit signal
                emit configNameChanged(name);
                emit temperatureChanged(temp);
                emit fanLevelChanged(fan);
                emit swingChanged(swing);
                emit alarmChanged(alarm);
                emit alarmStateChanged(alarm_state);
                emit operationModeChanged(operationMode);
            }
        }

        file.close();
    }
}

void Configuration::checkConfiguration()
{
    QFile file(CONFIG_PATH);
    // if file not exsit, create config file with default
    // configuration
    if (!file.exists()){
        createConfig("default",
                     25,
                     CustomDefine::LEVEL2,
                     CustomDefine::AUTO,
                     "20:15",
                     CustomDefine::ALARM_OFF,
                     CustomDefine::NORMAL);
    }
}

void Configuration::createConfig(QString configName,
                                  int temp,
                                  CustomDefine::air_condition_fan fanLevel,
                                  CustomDefine::air_condition_swing swing,
                                  QString alarm,
                                  CustomDefine::air_condition_alarm_state alarmState,
                                  CustomDefine::air_condition_mode operationMode)
{

    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text)){
        // load old config from file
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();
        // append new config
        QJsonObject newConfig;
        QJsonObject appendConfig;

        appendConfig["name"] = configName;
        appendConfig["temperature"] = temp;

        int m_OperatorMode;
        switch (operationMode) {
        case CustomDefine::NORMAL:
            m_OperatorMode = 1;
            break;
        case CustomDefine::FRESH:
            m_OperatorMode = 2;
            break;
        case CustomDefine::DRY:
            m_OperatorMode = 3;
            break;
        }
        appendConfig["operation mode"] =m_OperatorMode;

        int m_fan;
        switch (fanLevel) {
        case CustomDefine::LEVEL1:
            m_fan = 1;
            break;
        case CustomDefine::LEVEL2:
            m_fan = 2;
            break;
        case CustomDefine::LEVEL3:
            m_fan = 3;
            break;
        }
        appendConfig["fan level"] = m_fan;

        int m_swing;
        switch (swing) {
        case CustomDefine::UP:
            m_swing = 0;
            break;
        case CustomDefine::DOWN:
            m_swing = 1;
            break;
        case CustomDefine::AUTO:
            m_swing = 2;
            break;
        }
        appendConfig["swing"] = m_swing;

        appendConfig["alarm"] = alarm;
        appendConfig["alarm state"] = (alarmState == CustomDefine::ALARM_ON ? "ON" : "OFF");
        configJsonArr.append(appendConfig);

        newConfig.insert("config",configJsonArr );

        // write config to file
        file.resize(0);
        QJsonDocument doc(newConfig);
        file.write(doc.toJson(QJsonDocument::Indented));
        file.close();

    }
}

void Configuration::overWriteConfig(QString configName, int temp, CustomDefine::air_condition_fan fanLevel, CustomDefine::air_condition_swing swing, QString alarm, CustomDefine::air_condition_alarm_state alarmState, CustomDefine::air_condition_mode operationMode)
{
    QFile file(CONFIG_PATH);
       if(file.open(QIODevice::ReadWrite | QIODevice::Text)){
           // load configuration file
           QString configData = file.readAll();
           QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
           QJsonObject configJsonObject = configJsonDoc.object();
           QJsonArray configJsonArr = configJsonObject["config"].toArray();


           // Create object hold value of overwrite config
           QJsonObject overWriteConfig;
           QJsonArray newfigJsonArr;
           overWriteConfig["name"] = configName;
           overWriteConfig["temperature"] = temp;

           int m_OperatorMode;
           switch (operationMode) {
           case CustomDefine::NORMAL:
               m_OperatorMode = 1;
               break;
           case CustomDefine::FRESH:
               m_OperatorMode = 2;
               break;
           case CustomDefine::DRY:
               m_OperatorMode = 3;
               break;
           }
           overWriteConfig["operation mode"] =m_OperatorMode;

           int m_fan;
           switch (fanLevel) {
           case CustomDefine::LEVEL1:
               m_fan = 1;
               break;
           case CustomDefine::LEVEL2:
               m_fan = 2;
               break;
           case CustomDefine::LEVEL3:
               m_fan = 3;
               break;
           }
           overWriteConfig["fan level"] = m_fan;

           int m_swing;
           switch (swing) {
           case CustomDefine::UP:
               m_swing = 0;
               break;
           case CustomDefine::DOWN:
               m_swing = 1;
               break;
           case CustomDefine::AUTO:
               m_swing = 2;
               break;
           }
           overWriteConfig["swing"] = m_swing;
           overWriteConfig["alarm"] = alarm;
           overWriteConfig["alarm state"] = (alarmState == CustomDefine::ALARM_ON ? "ON" : "OFF");

           for (int i=0;i<configJsonArr.count();i++)
           {
               QString iteratorName = configJsonArr.at(i).toObject()["name"].toString();
               if(QString::compare(iteratorName,configName))
               {
                    newfigJsonArr.append(configJsonArr.at(i));
               }
               else
               {
                    newfigJsonArr.append(overWriteConfig);
               }
           }

           QJsonObject newConfigObj;
           newConfigObj.insert("config",newfigJsonArr );

           // write config to file
           file.resize(0);
           QJsonDocument doc(newConfigObj);
           file.write(doc.toJson(QJsonDocument::Indented));
           file.close();
}
}


