#include "worker.h"

Worker::Worker() : QThread(), m_threadActive{1}, m_tempSensor{-1}
{

}

Worker::~Worker()
{
    //delete QTimer
    //Safety stuff like turning off the relay
    qDebug()<<"worker has ben deleted";
}

void Worker::run()
{
    qDebug()<<"START HAS BEEN PRESSED";
    qDebug() << getTempSensor();
    setRelayOff();
    setRelayOn();
    while(m_threadActive)
    {
        //a very long process in here
    }
    qDebug()<<"STOP HAS BEEN PRESSED - thread is not active";
}

void Worker::setRelayOn()
{
    #ifdef __arm__
        digitalWrite(0,HIGH);
    #endif

    qDebug()<<"heating is on";
}
void Worker::setRelayOff()
{
    #ifdef __arm__
        digitalWrite(0,LOW);
    #endif
    qDebug()<<"heating is off";
}

float Worker::getTempSensor()
{
    std::system("./MAX31865.py");
    QFile file("tempSensor.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return -1;
    QTextStream in(&file);
    QString redTemp = in.readLine();
    return redTemp.toFloat();
}

void Worker::setThreadNotActive()
{
    m_threadActive = false;
}


