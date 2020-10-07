#ifndef INSTANTIABLE_H
#define INSTANTIABLE_H

#include <QObject>
#include <QDateTime>

class Instantiable: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int objectId READ objectId WRITE setObjectId NOTIFY objectIdChanged)
    Q_PROPERTY(QDateTime creationDate READ creationDate WRITE setCreationDate NOTIFY creationDateChanged)

public:
    Instantiable();

    int objectId() const;

    void setObjectId(int id);

    QString name() const;

    void setName(const QString& name);

    QDateTime creationDate() const;

    void setCreationDate(const QDateTime& dt);

signals:
    void nameChanged();
    void objectIdChanged();
    void creationDateChanged();

private:
    int m_objectId;
    QString m_name;
    QDateTime m_creationDate;
};

#endif // INSTANTIABLE_H
