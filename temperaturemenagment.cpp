#include "temperaturemenagment.h"
#include <QtDebug>

TemperatureMenagment::TemperatureMenagment(QObject *parent)
    : QObject{parent},
      m_tempInputVector{0,0,0,0},
      m_timeInputVector{0,0,0,0},
      m_loopInput{0}
{

}

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

}

