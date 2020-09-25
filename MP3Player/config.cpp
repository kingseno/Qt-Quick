#include "config.h"
#include <QDebug>
#include <QMediaPlayer>

#define CONFIG_PATH   "./config.json"

Config::Config(QObject* parent) : QObject(parent)
{
    checkConfiguration();
    loadListMusic();
}


void Config::setCurrentSrc(QString &dir){
    m_currentSrc = dir;
    emit currentSrcChanged();
}

void Config::setCurrentMp3Name(QString &name){
    m_currentName = name;
    emit currentNameChanged();
}

void Config::setCurrentIndex(int &index){
    m_currentIndex = index;
    emit currentIndexChanged();
}

void Config::setCurrentDuration(int &duration){
    m_currentDuration = duration;
    emit currentDurationChanged();
}

void Config::setCurrentPossition(int &possition){
    m_currentPossition = possition;
    emit currentPossitionChanged();

}

void Config::setCurrentVolume(qreal &currentVolume){
    m_currentVolume = currentVolume;
    emit currentVolumeChanged();
}

void Config::createConfigHandler(QString dir, QString nameMusic, int index, int duration, int position, qreal volume)
{
    this->m_currentName = nameMusic;
    this->m_currentSrc = dir;
    this->m_currentIndex = index;
    this->m_currentVolume = volume;
    this->m_currentDuration = duration;
    this->m_currentPossition = position;

    emit currentSrcChanged();
    emit currentNameChanged();
    emit currentIndexChanged();
    emit currentDurationChanged();
    emit currentPossitionChanged();
    emit currentVolumeChanged();
    if(!m_listMusic.contains(nameMusic))
    {
        //create and save config to json
        createConfig( dir,nameMusic,index,duration, position,volume);
        // update list_configurename
        m_listMusic.append( nameMusic);
        emit listMusicChanged();
    }
    else
    {
        qDebug() << "This music is already existent";
        removeMusic(nameMusic);
        createConfig( dir,nameMusic,index,duration, position,volume);
        m_listMusic.append( nameMusic);
        emit listMusicChanged();
    }
}

void Config::loadListMusic(){
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text)){
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();

        m_listMusic.clear();
        for(int i = 0; i< configJsonArr.count(); i++){
            m_listMusic.append(configJsonArr.at(i).toObject()["Mp3Name"].toString());
        }
        file.close();
    }
    qDebug () << "Loading List Music";
    emit listMusicChanged();
}

void Config::loadConfig(QString nameMusic){
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text )){
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();

        for (int i=0;i<configJsonArr.count();i++){

            if(configJsonArr.at(i).toObject()["Mp3Name"] == nameMusic){

                QString dir = configJsonArr.at(i).toObject()["Source"].toString();
                QString mp3Name = configJsonArr.at(i).toObject()["Mp3Name"].toString();
                int index = configJsonArr.at(i).toObject()["CurrentIndex"].toInt();
                int duration = configJsonArr.at(i).toObject()["CurrentDuration"].toInt();
                int possition = configJsonArr.at(i).toObject()["CurrentPossition"].toInt();
                qreal volume = configJsonArr.at(i).toObject()["CurrentVolume"].toDouble();

                this->m_currentSrc = dir;
                this->m_currentName = mp3Name;
                this->m_currentIndex = index;
                this->m_currentDuration = duration;
                this->m_currentPossition = possition;
                this->m_currentVolume = volume;

                emit currentSrcChanged();
                emit currentNameChanged();
                emit currentIndexChanged();
                emit currentDurationChanged();
                emit currentPossitionChanged();
                emit currentVolumeChanged();
            }
        }
        file.close();
    }

}

void Config::checkConfiguration()
{
    QFile file(CONFIG_PATH);
    if (!file.exists()){
        createConfig("file:/C:/Users/Default/Music", "ABC", 0, 0, 0, 0.5);
    }
}

void Config::createConfig(QString dir, QString nameMusic, int index, int duration, int position, qreal volume)
{
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text)){
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();

        QJsonObject newConfig;
        QJsonObject appendConfig;
        appendConfig["Mp3Name"] = nameMusic;
        appendConfig["Source"] = dir;
        appendConfig["CurrentIndex"] = index;
        appendConfig["CurrentVolume"] = volume;
        appendConfig["CurrentDuration"] = duration;
        appendConfig["CurrentPossition"] = position;

        configJsonArr.append(appendConfig);

        newConfig.insert("config",configJsonArr);
        newConfig.insert("current",appendConfig);

        file.resize(0);
        QJsonDocument doc(newConfig);
        file.write(doc.toJson(QJsonDocument::Indented));
        file.close();

    }

}

void Config::deleteConfig()
{
    QFile file(CONFIG_PATH);
    file.remove(CONFIG_PATH);
    m_listMusic.clear();
    emit listMusicChanged();
}

void Config::saveConfig(QString dir, QString nameMusic, int index, int duration, int position, qreal volume)
{
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text )){
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonObject saveConfigObject = configJsonObject["current"].toObject();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();

        QJsonObject newConfig;
        saveConfigObject["Mp3Name"] = nameMusic;
        saveConfigObject["Source"] = dir;
        saveConfigObject["CurrentIndex"] = index;
        saveConfigObject["CurrentVolume"] = volume;
        saveConfigObject["CurrentDuration"] = duration;
        saveConfigObject["CurrentPossition"] = position;

        newConfig.insert("config",configJsonArr);
        newConfig.insert("current",saveConfigObject);

        file.resize(0);
        QJsonDocument doc(newConfig);
        file.write(doc.toJson(QJsonDocument::Indented));
        file.close();
    }
}

void Config::loadHistoryConfig()
{
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text )){
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonObject configJsonObj = configJsonObject["current"].toObject();

        this->m_currentSrc = configJsonObj["Source"].toString();
        this->m_currentName = configJsonObj["Mp3Name"].toString();
        this->m_currentIndex = configJsonObj["CurrentIndex"].toInt();
        this->m_currentDuration = configJsonObj["CurrentDuration"].toInt();
        this->m_currentPossition = configJsonObj["CurrentPossition"].toInt();
        this->m_currentVolume = configJsonObj["CurrentVolume"].toDouble();

        emit currentSrcChanged();
        emit currentNameChanged();
        emit currentIndexChanged();
        emit currentDurationChanged();
        emit currentPossitionChanged();
        emit currentVolumeChanged();

        qDebug () << "Loading History Config";
        file.close();
    }
}

void Config::removeMusic(QString nameMusic)
{
    QFile file(CONFIG_PATH);
    if(file.open(QIODevice::ReadWrite | QIODevice::Text )){
        QString configData = file.readAll();
        QJsonDocument configJsonDoc = QJsonDocument::fromJson(configData.toUtf8());
        QJsonObject configJsonObject = configJsonDoc.object();
        QJsonArray configJsonArr = configJsonObject["config"].toArray();
        QJsonObject currentConfig = configJsonDoc["current"].toObject();

        for (int i=0;i<configJsonArr.count();i++){

            if(configJsonArr.at(i).toObject()["Mp3Name"] == nameMusic){
                configJsonArr.removeAt(i);
                emit listMusicChanged();
            }
        }
        QJsonObject newConfig;
        newConfig.insert("config", configJsonArr);
        newConfig.insert("current", currentConfig);

        file.resize(0);
        QJsonDocument doc(newConfig);
        file.write(doc.toJson(QJsonDocument::Indented));
        file.close();
    }

     if(m_listMusic.contains(nameMusic)){
         m_listMusic.removeOne(nameMusic);
         emit listMusicChanged();
     }
}

