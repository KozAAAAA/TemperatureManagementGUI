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

{}

    //------------------------------INPUT-----------------------------//
void MainGui::setInputParam(const QString& parameter, const quint32& value, const quint8 &index)
{
    if(parameter == "temp")
        m_tempInputVector.at(index) = value;
    else if(parameter == "time")
        m_timeInputVector.at(index) = value;
}

void MainGui::setInputParam(const QString& parameter, const quint8& value)
{
    if(parameter == "loop")
        m_loopInput= value;
}

void MainGui::printInputParam()
{
    qDebug();
    qDebug()<<"***********************************";
    qDebug() << "INPUT PARAMETERS FOR THE WORKER:";

    const std::array<QString, 3> vNames = {"temperature", "time", "loop"};
    quint8 i = 0;

    for (const auto &v : {m_tempInputVector, m_timeInputVector})
    {
        QDebug dbg(QtDebugMsg);
        dbg.nospace() << vNames.at(i) << ": [ ";
        for (const auto &vVal : v)
        {
            dbg << vVal << " ";
        }
        dbg << "], ";
        i++;
    }
    qDebug().nospace() << vNames.at(i)<< ": " << m_loopInput;
    qDebug()<<"***********************************";
    qDebug();

}
    //----------------------------------------------------------------//

    //-----------------------------OUTPUT-----------------------------//
quint16 MainGui::getTempOutput()
{
    return m_tempOutput;
}
void MainGui::setTempOutput(const quint16& newTemp)
{
    if (m_tempOutput != newTemp)
    {
        m_tempOutput = newTemp;
        emit tempOutputChanged();
    }
}

quint32 MainGui::getTimeOutput()
{
    return m_timeOutput;
}
void MainGui::setTimeOutput(const quint32& newTime)
{
    if (m_timeOutput != newTime)
    {
        m_timeOutput = newTime;
        emit timeOutputChanged();
    }
}

quint8 MainGui::getLoopOutput()
{
    return m_loopOutput;
}
void MainGui::setLoopOutput(const quint8& newLoop)
{
    if (m_loopOutput != newLoop)
    {
        m_loopOutput = newLoop;
        emit loopOutputChanged();
    }
}

quint8 MainGui::getBlockOutput()
{
    return m_blockOutput;
}
void MainGui::setBlockOutput(const quint8& newBlock)
{
    if (m_blockOutput != newBlock)
    {
        m_blockOutput = newBlock;
        emit blockOutputChanged();
    }
}

QString MainGui::getErrorOutput()
{
    return m_errorOutput;
}

void MainGui::setErrorOutput(const QString& newError)
{
    if (m_errorOutput != newError)
    {
        m_errorOutput = newError;
    }
    emit errorOutputChanged();
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
    connect(worker, &Worker::currentError, this, &MainGui::setErrorOutput);

    connect(worker, SIGNAL(finished()), worker, SLOT(deleteLater()));

    // QML CHANGE BUTTON & RELAY INDICATION:
    connect(worker, SIGNAL(finished()), this, SIGNAL(completedTemperatureControl()));
    connect(worker, SIGNAL(relayIsOn()), this, SIGNAL(heatingIsOn()));
    connect(worker, SIGNAL(relayIsOff()), this, SIGNAL(heatingIsOff()));

    worker->start();
}
void MainGui::endTemperatureControl()
{
    emit exitThread();
}
    //----------------------------------------------------------------//

