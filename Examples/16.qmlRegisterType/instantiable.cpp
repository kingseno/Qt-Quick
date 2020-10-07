#include "instantiable.h"

Instantiable::Instantiable()
{
    m_objectId = 0;
    m_name = "Dinh";
    m_creationDate = QDateTime::currentDateTime();
}

int Instantiable::objectId() const {
    return m_objectId;
}

void Instantiable::setObjectId(int id) {
    m_objectId = id;
    emit objectIdChanged();
}

QString Instantiable::name() const {
    return m_name;
}

void Instantiable::setName(const QString &name) {
    m_name = name;
    emit nameChanged();
}

QDateTime Instantiable::creationDate() const {
    return m_creationDate;
}

void Instantiable::setCreationDate(const QDateTime &dt) {
    m_creationDate = dt;
    emit creationDateChanged();
}
