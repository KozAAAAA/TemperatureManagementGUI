#include "worker.h"


Worker::Worker(const std::array<quint16, 4>& m_tempInputVector_,
               const std::array<quint16, 4>& m_timeInputVector_,
               const quint8& m_loopInput_) :
    QThread(),

    m_tempInputVector(m_tempInputVector_),
    m_timeInputVector(m_timeInputVector_),
    m_loopInput(m_loopInput_),

    m_threadActive(true),

    m_isRelayOn(true),

    m_pwd(QCoreApplication::applicationDirPath()),

    #ifdef __arm__
    m_scriptPath("/../../lib/MAX31865.py"),
    m_txtPath("/../../lib/tempSensor.txt")
    #else
    m_scriptPath("/../../test/MAX31865_sim.py"),
    m_txtPath("/../../test/tempSensor_sim.txt")
    #endif

    {
        setRelayOff();
        setFanOn();
        m_scriptPath.prepend(m_pwd);
        m_txtPath.prepend(m_pwd);
        qDebug()<<"WORKER: created";
    }

Worker::~Worker()
{
    setFanAndRelayOff();
    qDebug()<<"WORKER: destroyed";
}

    //------------------------------INPUT-----------------------------//
void Worker::setThreadNotActive()
{
    m_threadActive = false;
}
    //----------------------------------------------------------------//

    //-----------------------------METHODS----------------------------//
void Worker::run()
{
    qDebug()<<"THREAD: ON";

    for(quint8 currLoop = 1; currLoop < m_loopInput+1; currLoop++)
    {
        if(!m_threadActive) goto exitloop;
        emit currentLoop(currLoop);
        for(quint8 currBlock = 1; currBlock < 5; currBlock++)
        {
            if(!m_threadActive) goto exitloop;
            #if(DEBUGGING == true)
            quint32 workingTimeMs = 3600000 * m_timeInputVector[currBlock-1]/3600/100;
            #else
            quint32 workingTimeMs = 3600000 * m_timeInputVector[currBlock-1]/100;
            #endif
            if(workingTimeMs!=0 && m_threadActive)
            {
                QElapsedTimer timer;
                timer.start();
                emit currentBlock(currBlock);
                while((!timer.hasExpired(workingTimeMs)))
                {
                    if(!m_threadActive) goto exitloop;
                    quint32 currTime = (workingTimeMs - static_cast<quint32>(timer.elapsed()));
                    emit currentTime(currTime);
                    hysteresis(currBlock);
                }
            }
        }
    }
    exitloop:
    qDebug()<<"THREAD: OFF";
}
void Worker::hysteresis(const quint8& currBlock)
{
    qint16 readTemp = getTempSensor();

    if(readTemp == -1) return;

    emit currentTemp(static_cast<quint16>(readTemp));

    if(readTemp < m_tempInputVector[currBlock-1] + (H/2))
    {
        setRelayOn();
    }
    else if(readTemp > m_tempInputVector[currBlock-1] - (H/2))
    {
        setRelayOff();
    }

}

qint16 Worker::getTempSensor()
{
    int script = std::system(qPrintable(m_scriptPath));
    QFile txt(m_txtPath);

    if (script != 0)
    {
        emit currentError("Python script error!");
        setThreadNotActive();
        return -1;
    }

    if (!txt.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        emit currentError(".txt file error!");
        setThreadNotActive();
        return -1;
    }

    QTextStream in(&txt);
    qint16 readTemp = in.readLine().toShort();

    if (readTemp > 230 || readTemp < 0)
    {
        qDebug()<<"Temperature reading second attempt";
        readTemp = in.readLine().toShort();
        if (readTemp > 230 || readTemp < 0)
        {
            emit currentError("Temperature reading error!");
            setThreadNotActive();
            return -1;
        }
    }
    return readTemp;
}

void Worker::setRelayOn()
{
    if(m_isRelayOn == false)
    {
        #ifdef __arm__
            digitalWrite(RELAY,HIGH);
        #endif

        m_isRelayOn = true;

        emit relayIsOn();

        qDebug()<<"HEATER: ON";
    }
}
void Worker::setRelayOff()
{
    if(m_isRelayOn == true)
    {
        #ifdef __arm__
            digitalWrite(RELAY,LOW);
        #endif

        m_isRelayOn = false;

        emit relayIsOff();

        qDebug()<<"HEATING: OFF";
    }
}
void Worker::setFanOn()
{
    #ifdef __arm__
        digitalWrite(FAN,HIGH);
    #endif
    qDebug()<<"FAN: ON";
}
void Worker::setFanOff()
{
    #ifdef __arm__
        digitalWrite(FAN,LOW);
    #endif
    qDebug()<<"FAN: OFF";
}
void Worker::setFanAndRelayOff()
{
    setRelayOff();
    setFanOff();
}

    //----------------------------------------------------------------//
