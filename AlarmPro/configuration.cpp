#include "configuration.h"
#include <QDebug>
#include <QJsonArray>

#define CONFIG_PATH "./config.json"

Configuration::Configuration(QObject *parent) : QObject(parent)
{
    m_infoAlarm = 0;
    checkConfiguration ();
    loadAlarms ();
}

int Configuration::infoAlarm () const {
    return m_infoAlarm;
}

void Configuration::setInfoAlarm (const int &infoAlarm) {
    if (infoAlarm != m_infoAlarm) {
        m_infoAlarm = infoAlarm;
        emit infoAlarmChanged();
    }
}

void Configuration::saveChanges (QVariantList alarmInfo) {

    QFile file(CONFIG_PATH);

    if (file.open(QIODevice::ReadWrite | QIODevice::Text)) {

        // Delete all data in json file
        file.resize(0);

        QJsonObject configJsonObject, jsonObjectForDaysToRepeat;
        QJsonArray configJsonArr, jsonArrForDaysToRepeat;

        QJsonObject newConfig;

        for (int i = 0; i < alarmInfo.count(); i++) {
            configJsonObject["hour"] =  alarmInfo.at(i).toMap().value("hour")
                    .toInt ();
            configJsonObject["minute"] =  alarmInfo.at(i).toMap().value("minute")
                    .toInt ();
            configJsonObject["day"] =  alarmInfo.at(i).toMap().value("day")
                    .toInt ();
            configJsonObject["month"] =  alarmInfo.at(i).toMap().value("month")
                    .toInt ();
            configJsonObject["year"] =  alarmInfo.at(i).toMap().value("year")
                    .toInt ();
            configJsonObject["activated"] =  alarmInfo.at(i).toMap().value("activated")
                    .toBool ();
            configJsonObject["label"] =  alarmInfo.at(i).toMap().value("label")
                    .toString ();
            configJsonObject["repeat"] =  alarmInfo.at(i).toMap().value("repeat")
                    .toBool ();

            for (int j = 0; j < alarmInfo.at(i).toMap().value("daysToRepeat")
                 .toList ().count (); j++) {
                jsonObjectForDaysToRepeat["dayOfWeek"] =
                        alarmInfo.at(i).toMap().value("daysToRepeat").toList ()
                        .at(j).toMap().value("dayOfWeek").toInt ();
                jsonObjectForDaysToRepeat["repeat"] =
                        alarmInfo.at(i).toMap().value("daysToRepeat").toList ()
                        .at(j).toMap().value("repeat").toBool ();

                jsonArrForDaysToRepeat.append (jsonObjectForDaysToRepeat);
            }

            configJsonObject["daysToRepeat"] = jsonArrForDaysToRepeat;
            jsonArrForDaysToRepeat = {}; // reset array
            configJsonArr.append (configJsonObject);

        }

        newConfig.insert("config", configJsonArr);

        QJsonDocument doc(newConfig);
        file.write(doc.toJson(QJsonDocument::Indented));
        file.close();

    }
}

QJsonObject Configuration::loadAlarms () {
    QFile file(CONFIG_PATH);

    if (file.open(QIODevice::ReadWrite | QIODevice::Text)) {
        // load old config from file
        QString configData = file.readAll();
        QJsonDocument configJsonDoc =
                QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        return configJsonObject;

    }
}

void Configuration::checkConfiguration () {
    QFile file(CONFIG_PATH);
    if (!file.exists()) {

    }
}

