#include "config.h"

Config::Config(QObject *parent) : QObject(parent)
{
    m_price = 10;
}

int Config::getPrice() const
{
    return m_price;
}

void Config::setPrice(const int price)
{
    qDebug("cc");
    if (price != m_price) {

        m_price = price;
        emit priceChanged();
    }
}

void Config::setPrice2(const int price)
{
    qDebug("cccc");
    if (price != m_price) {

        m_price = price;
        emit priceChanged();
    }
}
