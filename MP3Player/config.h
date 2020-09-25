#ifndef CONFIG_H
#define CONFIG_H

#include <QObject>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QString>
#include <QFile>
#include <QMediaPlayer>
#include <QMediaMetaData>


class Config : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList listMusic READ GetListMusicName NOTIFY listMusicChanged)
    Q_PROPERTY(QString currentDir READ getCurrentSrc WRITE setCurrentSrc NOTIFY currentSrcChanged)
    Q_PROPERTY(QString currentName READ getCurrentMp3Name WRITE setCurrentMp3Name NOTIFY currentNameChanged)
    Q_PROPERTY(int currentIndex READ getCurrentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged)
    Q_PROPERTY(int currentDuration READ getCurrentDuration WRITE setCurrentDuration NOTIFY currentDurationChanged)
    Q_PROPERTY(int currentPossition READ getCurrentPossition WRITE setCurrentPossition NOTIFY currentPossitionChanged)
    Q_PROPERTY(qreal currentVolume READ getCurrentVolume WRITE setCurrentVolume NOTIFY currentVolumeChanged)

public:
    Config(QObject* parent = nullptr);
    QStringList GetListMusicName() const  {return m_listMusic;}
    QString getCurrentMp3Name()const {return m_currentName;}
    QString getCurrentSrc()const {return m_currentSrc;}
    int getCurrentIndex() const {return m_currentIndex;}
    int getCurrentDuration() const {return m_currentDuration;}
    int getCurrentPossition() const {return m_currentPossition;}
    qreal getCurrentVolume() const {return m_currentVolume;}

    void setCurrentMp3Name(QString &name);
    void setCurrentSrc(QString &dir);
    void setCurrentIndex(int &index);
    void setCurrentDuration(int &duration);
    void setCurrentPossition(int &possition);
    void setCurrentVolume(qreal &volume);

    Q_INVOKABLE void loadConfig(QString nameMusic);
    Q_INVOKABLE void createConfigHandler(QString dir, QString nameMusic, int index, int duration, int position, qreal volume);
    Q_INVOKABLE void deleteConfig();
    Q_INVOKABLE void saveConfig(QString dir, QString nameMusic, int index, int duration, int position, qreal volume);
    Q_INVOKABLE void loadHistoryConfig();
    Q_INVOKABLE void removeMusic(QString nameMusic);

private:
    void createConfig(QString dir, QString nameMusic, int index, int duration, int position, qreal volume);
    void checkConfiguration();
    void loadListMusic();


signals:
    void listMusicChanged();
    void currentSrcChanged();
    void currentNameChanged();
    void currentIndexChanged();
    void currentDurationChanged();
    void currentPossitionChanged();
    void currentVolumeChanged();

private:
    QString m_currentName;
    QString m_currentSrc;
    int m_currentIndex;
    int m_currentDuration;
    int m_currentPossition;
    qreal m_currentVolume;
    QStringList m_listMusic;
};

#endif // CONFIG_H
