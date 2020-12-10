#ifndef CONFIG_H
#define CONFIG_H

#include <QObject>

class Config : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int price1 READ getPrice WRITE setPrice NOTIFY priceChanged)
public:
    explicit Config(QObject *parent = nullptr);
    int getPrice() const;
    Q_INVOKABLE void setPrice2(const int price);
signals:
    void priceChanged();
public slots:
    void setPrice(const int price);

private:
    int m_price;
};

#endif // CONFIG_H
