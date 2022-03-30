#include "temperaturemenagment.h"
#include <QtDebug>

TemperatureMenagment::TemperatureMenagment(QObject *parent)
    : QObject{parent},
      m_tempInputVector{0,0,0,0},
      m_timeInputVector{0,0,0,0},
      m_loopInput{0}
{

}

void TemperatureMenagment::setInputParam(const QString& parameter, const uint16_t& value, const uint8_t &index)
{
    if(parameter == "temp")
        m_tempInputVector.at(index) = value;
    else if(parameter == "temp")
        m_timeInputVector.at(index) = value;
    else
        qDebug()<<"There is no such parameter as:"<< parameter;
}

void TemperatureMenagment::setInputParam(const QString& parameter, const uint16_t& value)
{
    if(parameter == "loop")
        m_loopInput= value;
    else qDebug()<<"There is no such parameter as:"<< parameter;
}

int TemperatureMenagment::getInputParam(int index)
{
    return m_tempInputVector.at(index);
}

//int TemperatureMenagment::getTemp()
//{
//    return m_tempVector[index];
//}

//void TemperatureMenagment::setTemp(int& newTemp)
//{


//        m_tempVector = newTemp;
//        emit tempChanged();

//}

