#include "worker.h"




Worker::Worker(const std::vector<quint16>& m_tempInputVector_,
               const std::vector<quint16>& m_timeInputVector_,
               const quint8& m_loopInput_) :
    QThread(),

    m_tempInputVector(m_tempInputVector_),
    m_timeInputVector(m_timeInputVector_),
    m_loopInput(m_loopInput_),

    m_threadActive(true),

    m_currentTemp(0),
    m_currentTime(0),
    m_currentLoop(1),
    m_currentBlock(1)

    {setRelayOff();}

Worker::~Worker()
{
    setRelayOff();
    qDebug()<<"worker has ben deleted";
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
    qDebug()<<"START HAS BEEN PRESSED";

    while(m_threadActive)
    {
        m_currentTemp = getTempSensor();

        //loop
        for(;m_currentLoop < m_loopInput+1;m_currentLoop++)
        {
            emit currentLoop(m_currentLoop);

            //block
            for(;m_currentBlock < 5; m_currentBlock++)
            {
                emit currentBlock(m_currentBlock);

                //timer
                //przemyśleć
                //m_currentTime = m_timeInputVector[m_currentBlock]

                while(m_currentTime>0)
                {
                    emit currentTime(m_currentTime);
                    pid();
                }

            }
        }
    }

    outputReset();
    qDebug()<<"STOP HAS BEEN PRESSED - thread is not active";
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
void Worker::outputReset()
{
    emit currentTemp(0);
    emit currentTime(0);
    emit currentLoop(0);
    emit currentBlock(0);
}
void Worker::pid()
{
    m_currentTemp = getTempSensor();
    emit currentTemp(m_currentTemp);
    if(m_currentTemp < m_tempInputVector[m_currentBlock])
    {
        setRelayOn();
    }
    else
    {
        setRelayOff();
    }
}
    //----------------------------------------------------------------//
