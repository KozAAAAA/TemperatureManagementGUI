#ifndef TEMPERATUREMENAGMENT_H

#define TEMPERATUREMENAGMENT_H

#define TEMP "temp"
#define TIME "time"
#define LOOP "loop"

#include <QObject>
#include <QtDebug>
#include <iostream>
#include <array>

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
    std::array<quint16,4> m_tempInputVector;
    std::array<quint16,4> m_timeInputVector;
    quint8 m_loopInput;

    //----------------------------------------------------------------//

    //-----------------------------OUTPUT-----------------------------//
public:
    Q_PROPERTY(quint16 tempOutput READ getTempOutput WRITE setTempOutput NOTIFY tempOutputChanged);
    Q_PROPERTY(quint32 timeOutput READ getTimeOutput WRITE setTimeOutput NOTIFY timeOutputChanged);
    Q_PROPERTY(quint8 loopOutput READ getLoopOutput WRITE setLoopOutput NOTIFY loopOutputChanged);
    Q_PROPERTY(quint8 blockOutput READ getBlockOutput WRITE setBlockOutput NOTIFY blockOutputChanged);
    Q_PROPERTY(QString errorOutput READ getErrorOutput WRITE setErrorOutput NOTIFY errorOutputChanged)

    quint16 getTempOutput();
    quint32 getTimeOutput();
    quint8 getLoopOutput();
    quint8 getBlockOutput();
    QString getErrorOutput();

public slots:
    void setTempOutput(const quint16& newTemp);
    void setTimeOutput(const quint32& newTime);
    void setLoopOutput(const quint8& newLoop);
    void setBlockOutput(const quint8& newBlock);
    void setErrorOutput(const QString& newError);

private:
    quint16 m_tempOutput;
    quint32 m_timeOutput;
    quint8 m_loopOutput;
    quint8 m_blockOutput;
    QString m_errorOutput;

signals:
    void tempOutputChanged();
    void timeOutputChanged();
    void loopOutputChanged();
    void blockOutputChanged();
    void errorOutputChanged();

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
