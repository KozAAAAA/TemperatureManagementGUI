#include <QtDebug>
#include <QFile>
#ifdef __arm__
    #include <wiringPi.h>
#endif


#include "worker.h"
#include "temperaturemenagment.h"




TemperatureMenagment::TemperatureMenagment(QObject *parent)
    : QObject{parent},
      m_tempInputVector{0,0,0,0},
      m_timeInputVector{0,0,0,0},
      m_loopInput{0},

      m_tempOutput{0},
      m_timeOutput{0},
      m_loopOutput{0},
      m_blockOutput{0},

      m_tempSensor{0}

{
    #ifdef __arm__
        wiringPiSetup();
        pinMode(0,OUTPUT);
    #endif

    qDebug()<< getTempSensor();
    setRelayOff();

}
        //------------------------------INPUT-----------------------------//
void TemperatureMenagment::setInputParam(const QString& parameter, const int& value, const int &index)
{
    if(parameter == TEMP)
        m_tempInputVector.at(index) = value;
    else if(parameter == TIME)
        m_timeInputVector.at(index) = value;
}

void TemperatureMenagment::setInputParam(const QString& parameter, const int& value)
{
    if(parameter == LOOP)
        m_loopInput= value;
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
float TemperatureMenagment::getTempSensor()
{
    std::system("./MAX31865.py");
    QFile file("tempSensor.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return -1;
    QTextStream in(&file);
    QString redTemp = in.readLine();
    return redTemp.toFloat();
}
void TemperatureMenagment::setRelayOn()
{
    #ifdef __arm__
        digitalWrite(0,HIGH);
    #endif

    qDebug()<<"heating is on";
}
void TemperatureMenagment::setRelayOff()
{
    #ifdef __arm__
        digitalWrite(0,LOW);
    #endif
    qDebug()<<"heating is off";
}
void TemperatureMenagment::temperatureControl()
{
    setTempOutput(5);
    auto worker = new Worker();
    connect(worker, &Worker::mySignal, this, &TemperatureMenagment::print);
    connect(worker, SIGNAL(finished()), worker, SLOT(deleteLater()));
    worker->start();
}

void TemperatureMenagment::print()
{
    qDebug()<<"signal!!";
}
        //----------------------------------------------------------------//
