#include "worker.h"

Worker::Worker(const std::vector<uint16_t>& m_tempInputVector_,
               const std::vector<uint16_t>& m_timeInputVector_,
               const uint8_t& m_loopInput_) :
    QThread(),

    m_threadActive(true),

    m_tempInputVector(m_tempInputVector_),
    m_timeInputVector(m_timeInputVector_),
    m_loopInput(m_loopInput_),

    m_currentTemp(-1),
    m_currentTime(-1),
    m_currentLoop(-1),
    m_currentBlock(-1)

{
    setRelayOff();
}

Worker::~Worker()
{
    //delete QTimer
    setRelayOff();
    qDebug()<<"worker has ben deleted";
}

void Worker::run()
{
    qDebug()<<"START HAS BEEN PRESSED";

    while(m_threadActive)
    {
        m_currentTemp = getTempSensor();
        m_currentTime = 5;
        m_currentLoop = 2;
        m_currentBlock = 2;
        emit currentTemp(m_currentTemp);
        emit currentTime(m_currentTime);
        emit currentLoop(m_currentLoop);
        emit currentBlock(m_currentBlock);
        qDebug()<<m_currentTemp;
        if(m_currentTemp>27)
        {
            setRelayOn();
        }
        else(setRelayOff());
    }

    outputReset();

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

void Worker::outputReset()
{
    emit currentTemp(0);
    emit currentTime(0);
    emit currentLoop(0);
    emit currentBlock(0);
}


