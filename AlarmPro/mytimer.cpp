#include "mytimer.h"

MyTimer::MyTimer(QObject *parent) : QObject(parent)
{

}

void MyTimer::start() {
    this->m_elapsed = 0;
    this->m_running = true;

    m_timer.start();
    emit runningChanged();
}

void MyTimer::stop() {
    this->m_elapsed = m_timer.elapsed();
    this->m_running = false;

    emit elapsedChanged();
    emit runningChanged();
}
