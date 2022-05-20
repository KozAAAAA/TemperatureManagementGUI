#ifndef TEMPERATUREMENAGMENT_H

#define TEMPERATUREMENAGMENT_H

#define TEMP "temp"
#define TIME "time"
#define LOOP "loop"

#include <QObject>
#include <QtDebug>

#include "worker.h"

class MainGui : public QObject
{
    Q_OBJECT
public:
    explicit MainGui(QObject *parent = nullptr);

    //------------------------------INPUT-----------------------------//
public:
    Q_INVOKABLE void setInputParam (const QString& parameter, const quint32& value,const quint8& index);
    Q_INVOKABLE void setInputParam (const QString& parameter, const quint8& value);

    //debug:
    Q_INVOKABLE void printInputParam();

private:
    std::vector<quint16> m_tempInputVector;
    std::vector<quint16> m_timeInputVector;
    quint8 m_loopInput;
    //----------------------------------------------------------------//

    //-----------------------------OUTPUT-----------------------------//
public:
    Q_PROPERTY(int tempOutput READ getTempOutput WRITE setTempOutput NOTIFY tempOutputChanged)
    Q_PROPERTY(int timeOutput READ getTimeOutput WRITE setTimeOutput NOTIFY timeOutputChanged)
    Q_PROPERTY(int loopOutput READ getLoopOutput WRITE setLoopOutput NOTIFY loopOutputChanged)
    Q_PROPERTY(int blockOutput READ getBlockOutput WRITE setBlockOutput NOTIFY blockOutputChanged)

    quint16 getTempOutput();
    quint32 getTimeOutput();
    quint8 getLoopOutput();
    quint8 getBlockOutput();

public slots:
    void setTempOutput(const quint16& newTemp);
    void setTimeOutput(const quint32& newTime);
    void setLoopOutput(const quint8& newLoop);
    void setBlockOutput(const quint8& newBlock);

private:
    quint16 m_tempOutput;
    quint32 m_timeOutput;
    quint8 m_loopOutput;
    quint8 m_blockOutput;

signals:
    void tempOutputChanged();
    void timeOutputChanged();
    void loopOutputChanged();
    void blockOutputChanged();
    void completedTemperatureControl();
    void heatingIsOn();
    void heatingIsOff();

    //----------------------------------------------------------------//

    //----------------------THREAD-COMMUNICATION----------------------//
private:
    Worker* worker;
public:
    Q_INVOKABLE void startTemperatureControl();
    Q_INVOKABLE void endTemperatureControl();
signals:
    void exitThread();
    //----------------------------------------------------------------//
};

#endif // TEMPERATUREMENAGMENT_H
