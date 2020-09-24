/****************************************************************************
** Project                  = Alarm13 Super ProMax
** Author                   = Dinh Pham
** Version                  = V1.0.0
** Date                     = 23/09/2020
**
*****************************************************************************
** Purpose of this file:
**
*****************************************************************************
** Lisense
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** Copyright (C) 2020 by Dinh Pham
**
*****************************************************************************
**                      Revision Control History
** V1.0.0:  23/09/2020  : Initial version.
**
****************************************************************************/

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

