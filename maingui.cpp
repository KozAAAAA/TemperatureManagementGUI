#include "worker.h"
#include "maingui.h"




MainGui::MainGui(QObject *parent)
    : QObject{parent},
      m_tempInputVector{0,0,0,0},
      m_timeInputVector{0,0,0,0},
      m_loopInput{0},

      m_tempOutput{0},
      m_timeOutput{0},
      m_loopOutput{0},
      m_blockOutput{0}


{
    #ifdef __arm__
        wiringPiSetup();
        pinMode(0,OUTPUT);
        digitalWrite(0,LOW);
    #endif
}
        //------------------------------INPUT-----------------------------//
void MainGui::setInputParam(const QString& parameter, const int& value, const int &index)
{
    if(parameter == TEMP)
        m_tempInputVector.at(index) = value;
    else if(parameter == TIME)
        m_timeInputVector.at(index) = value;
}

void MainGui::setInputParam(const QString& parameter, const int& value)
{
    if(parameter == LOOP)
        m_loopInput= value;
}

void MainGui::printInputParam()
{
    qDebug()<<"tempVector:";
    for (uint16_t temp : m_tempInputVector)
    {
        qDebug()<<temp;
    }
    qDebug()<<"timeVector:";
    for (uint16_t time : m_timeInputVector)
    {
        qDebug()<<time;
    }
    qDebug()<<"loop:"<< m_loopInput;
}
        //----------------------------------------------------------------//

        //-----------------------------OUTPUT-----------------------------//
int MainGui::getTempOutput()
{
    return m_tempOutput;
}
void MainGui::setTempOutput(const uint16_t& newTemp)
{
    if (m_tempOutput != newTemp)
    {
        m_tempOutput = newTemp;
        emit tempOutputChanged();
    }
}

int MainGui::getTimeOutput()
{
    return m_timeOutput;
}
void MainGui::setTimeOutput(const uint16_t& newTime)
{
    if (m_timeOutput != newTime)
    {
        m_timeOutput = newTime;
        emit timeOutputChanged();
    }
}

int MainGui::getLoopOutput()
{
    return m_loopOutput;
}
void MainGui::setLoopOutput(const uint8_t& newLoop)
{
    if (m_loopOutput != newLoop)
    {
        m_loopOutput = newLoop;
        emit loopOutputChanged();
    }
}

int MainGui::getBlockOutput()
{
    return m_blockOutput;
}
void MainGui::setBlockOutput(const uint8_t& newBlock)
{
    if (m_blockOutput != newBlock)
    {
        m_blockOutput = newBlock;
        emit blockOutputChanged();
    }
}
        //----------------------------------------------------------------//

        //----------------------THREAD-COMMUNICATION----------------------//

void MainGui::startTemperatureControl()
{
    worker = new Worker(m_tempInputVector, m_timeInputVector, m_loopInput);

    connect(this, &MainGui::exitThread, worker, &Worker::setThreadNotActive);

    connect(worker, &Worker::currentTemp, this, &MainGui::setTempOutput);
    connect(worker, &Worker::currentTime, this, &MainGui::setTimeOutput);
    connect(worker, &Worker::currentLoop, this, &MainGui::setLoopOutput);
    connect(worker, &Worker::currentBlock, this, &MainGui::setBlockOutput);


    connect(worker, SIGNAL(finished()), worker, SLOT(deleteLater()));
    worker->start();
}

void MainGui::endTemperatureControl()
{
    emit exitThread();
}
        //----------------------------------------------------------------//

