#ifndef HANDLEKEY_H
#define HANDLEKEY_H
#include <QtCore/QObject>

class HandleKey: public QObject {
    Q_OBJECT
    Q_PROPERTY(int getTemp READ getTemp NOTIFY tempChanged)
public:
    int getTemp() const;
public slots:
    void handleKeyPower();
    void handleKeyDown();
    void handleKeyUp();
    void handleKeySetting();
    void handleKeyAuto();
    void setTemp(int const&);
signals:
    void tempChanged(int);
private:
    int m_temperature = 20;
};

#endif // HANDLEKEY_H
