#include "handlekey.h"
#include "statescr.h"
#include  <QDebug>

void HandleKey::handleKeyPower() {
    auto& state = StateScr::get_instance();
    switch (state.get_state()) {
        case 0:
            state.set_state(1);
            qDebug() << "123456";
            break;
        case 1:
            state.set_state(0);
            qDebug() << "adasdasd";
            break;
        default:
            state.set_state(0);
    }
}
void HandleKey::handleKeyUp() {
    if (m_temperature >= 0 && m_temperature <= 34)
        {
            m_temperature++;
            setTemp(m_temperature);
        }
}

void HandleKey::handleKeyDown() {   
    if( m_temperature > 0 && m_temperature <= 35)
        {
            m_temperature--;
            setTemp(m_temperature);
        }
}

void HandleKey::handleKeySetting() {
    qDebug() << "handleKeySetting";
    auto& state = StateScr::get_instance();
    switch (state.get_state()) {
        case 0:
            state.set_state(1);
            break;
        case 1:
            state.set_state(0);
            break;
        default:
            state.set_state(0);
    }
}

void HandleKey::handleKeyAuto() {
    auto& state = StateScr::get_instance();
    switch (state.get_state()) {
        case 0:
            state.set_state(1);
            break;
        case 1:
            state.set_state(0);
            break;
        default:
            state.set_state(0);
    }
}

int HandleKey::getTemp() const {
    return m_temperature;
}

void HandleKey::setTemp(int const& temp) {
    m_temperature = temp;
    qDebug()<<m_temperature;
    emit tempChanged(m_temperature);
}

