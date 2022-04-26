#include "temperaturemenagment.h"
#include <QtDebug>
#include <fstream>
#include <QFile>

TemperatureMenagment::TemperatureMenagment(QObject *parent)
    : QObject{parent},
      m_tempInputVector{0,0,0,0},
      m_timeInputVector{0,0,0,0},
      m_loopInput{0},

      m_tempOutput{0},
      m_timeOutput{0},
      m_loopOutput{0},
      m_blockOutput{0}
{
    qDebug()<<getTempSensor();
    setRelayOn();
    setRelayOff();
}
        //------------------------------INPUT-----------------------------//
void TemperatureMenagment::setInputParam(const QString& parameter, const int& value, const int &index)
{
    if(parameter == "temp")
        m_tempInputVector.at(index) = value;
    else if(parameter == "time")
        m_timeInputVector.at(index) = value;
    else
        qDebug()<<"There is no such parameter as:"<< parameter;
}

void TemperatureMenagment::setInputParam(const QString& parameter, const int& value)
{
    if(parameter == "loop")
        m_loopInput= value;
    else qDebug()<<"There is no such parameter as:"<< parameter;
}

void TemperatureMenagment::printInputParam()
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


    //do wyjebania, testy!!!!
    setTempOutput(m_tempInputVector[0]);
    setTimeOutput(m_timeInputVector[0]);
    setLoopOutput(m_loopInput);
    setBlockOutput(m_loopInput);
    //
}
        //----------------------------------------------------------------//

        //-----------------------------OUTPUT-----------------------------//
int TemperatureMenagment::getTempOutput()
{
    return m_tempOutput;
}
void TemperatureMenagment::setTempOutput(const uint16_t& newTemp)
{
    if (m_tempOutput != newTemp)
    {
        m_tempOutput = newTemp;
        emit tempOutputChanged();
    }
}

int TemperatureMenagment::getTimeOutput()
{
    return m_timeOutput;
}
void TemperatureMenagment::setTimeOutput(const uint16_t& newTime)
{
    if (m_timeOutput != newTime)
    {
        m_timeOutput = newTime;
        emit timeOutputChanged();
    }
}

int TemperatureMenagment::getLoopOutput()
{
    return m_loopOutput;
}
void TemperatureMenagment::setLoopOutput(const uint8_t& newLoop)
{
    if (m_loopOutput != newLoop)
    {
        m_loopOutput = newLoop;
        emit loopOutputChanged();
    }
}

int TemperatureMenagment::getBlockOutput()
{
    return m_blockOutput;
}
void TemperatureMenagment::setBlockOutput(const uint8_t& newBlock)
{
    if (m_blockOutput != newBlock)
    {
        m_blockOutput = newBlock;
        emit blockOutputChanged();
    }
}
        //----------------------------------------------------------------//
        //-----------------------GPIO-(SPI-&-RELAY)-----------------------//
QString TemperatureMenagment::getTempSensor()
{
    std::system("./MAX31865.py");
    QFile file("tempSensor.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return 0;
    QTextStream in(&file);
    QString redTemp = in.readLine();
    return redTemp;
}
void TemperatureMenagment::setRelayOn()
{
    qDebug()<<"heating on";
    //coil trun on
}
void TemperatureMenagment::setRelayOff()
{
    qDebug()<<"heating off";
    //coil turn off
}
void temperatureControl()
{
    //a very complicated code in here
}
        //----------------------------------------------------------------//
