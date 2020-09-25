#include "statescr.h"

StateScr::StateScr() : m_state(0) {}

StateScr::~StateScr() {}

StateScr& StateScr::get_instance() {
    static StateScr instance;
    return instance;
}

void StateScr::set_state(const int &state) {
    m_state = state;
}

int StateScr::get_state() {
    return m_state;
}

