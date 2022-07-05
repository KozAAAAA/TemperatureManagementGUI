#include "worker.h"


Worker::Worker(const std::array<quint16, 4>& m_tempInputVector_,
               const std::array<quint16, 4>& m_timeInputVector_,
               const quint8& m_loopInput_) :
    QThread(),

    m_tempInputVector(m_tempInputVector_),
    m_timeInputVector(m_timeInputVector_),
    m_loopInput(m_loopInput_),

    m_threadActive(true),

    m_currentTemp(0),
    m_currentTime(0),
    m_currentLoop(1),
    m_currentBlock(1),

    m_isRelayOn(true)

    {
        qDebug()<<"WORKER: created";
        setRelayOff();
        setFanOn();
    }

Worker::~Worker()
{
    setRelayOff();
    setFanOff();
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

    for(;m_currentLoop < m_loopInput+1;m_currentLoop++)
    {
        emit currentLoop(m_currentLoop);
        for(;m_currentBlock < 5; m_currentBlock++)
        {

        #if(DEBUGGING == true)
            quint32 m_workingTimeMs = 36e5 * m_timeInputVector[m_currentBlock-1]/3600/100;
        #else
            quint32 m_workingTimeMs = 36e5 * m_timeInputVector[m_currentBlock-1]/100;
        #endif

        m_timer.start();

        if(m_workingTimeMs!=0)
        {
            emit currentBlock(m_currentBlock);

            while((!m_timer.hasExpired(m_workingTimeMs)) &&
                    m_threadActive)
            {
            m_currentTime = (m_workingTimeMs - m_timer.elapsed());
            emit currentTime(m_currentTime);

            hysteresis();
            }
        }
        }
        m_currentBlock = 0;
    }
    m_currentLoop = 0;
    outputReset();

    qDebug()<<"THREAD: OFF";
}
void Worker::hysteresis()
{
    try
    {
        m_currentTemp = getTempSensor();
    }
    catch (const char* err)
    {
        setThreadNotActive();
        qCritical() <<"ERROR:"<< err;
        emit currentError(err);
    }
    catch(...)
    {
        setThreadNotActive();
        qCritical() <<"ERROR:"<< "unknown";
        emit currentError("unknown");
    }


    emit currentTemp(m_currentTemp);
    if(m_currentTemp < m_tempInputVector[m_currentBlock-1] + (H/2))
    {
        setRelayOn();
    }
    if(m_currentTemp > m_tempInputVector[m_currentBlock-1] - (H/2))
    {
        setRelayOff();
    }

}

float Worker::getTempSensor()
{

#ifdef __arm__
    auto script = std::system("../../lib/MAX31865.py");
    QFile file("../../lib/tempSensor.txt");
#else
    auto script = std::system("../../test/MAX31865_sim.py");
    QFile file("../../test/tempSensor_sim.txt");
#endif

    if (script != 0)
        throw "I can't find the python script!";

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        throw "I can't find the .txt file!";

    QTextStream in(&file);

    float readTemp = in.readLine().toFloat();

    if (readTemp > 230 || readTemp < 0)
        throw "Temperature reading is a thrash value!";

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
void Worker::outputReset()
{
    emit currentTemp(0);
    emit currentTime(0);
    emit currentLoop(0);
    emit currentBlock(0);
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

    //----------------------------------------------------------------//
