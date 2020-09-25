#ifndef SERVICE_H
#define SERVICE_H

#include <QObject>
#include <QDesktopServices>
#include <QUrl>

class Service : public QObject
{
        Q_OBJECT
public:
    Service(QObject* parent = nullptr);

public slots:
    void openService(int id);
};

#endif // SERVICE_H
