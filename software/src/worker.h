#ifndef WORKER_H

#define WORKER_H

#include <QThread>
#include <QObject>
#include <QDebug>
#include <QFile>
#include <QElapsedTimer>

#ifdef __arm__
    #include <wiringPi.h>
#endif


#define H 5 // adjust to change the behaviour of hysteresis
#define RELAY 0
#define FAN 7



class Worker : public QThread
{
    Q_OBJECT
public:
    explicit Worker(const std::array<quint16,4>&,
                    const std::array<quint16,4>&,
                    const quint8&);
    ~Worker();

    //------------------------------INPUT-----------------------------//
private:
    const std::array<quint16, 4> m_tempInputVector;
    const std::array<quint16, 4> m_timeInputVector;
    const quint8 m_loopInput;

    bool m_threadActive;

public slots:
    void setThreadNotActive();
    //----------------------------------------------------------------//

    //-----------------------------OUTPUT-----------------------------//
private:
    float m_currentTemp;
    quint32 m_currentTime;
    quint8 m_currentLoop;
    quint8 m_currentBlock;

signals:
    void currentTemp(const quint16);
    void currentTime(const quint32);
    void currentLoop(const quint8);
    void currentBlock(const quint8);
    void currentError(const QString);

    void relayIsOn();
    void relayIsOff();
    //----------------------------------------------------------------//

    //-----------------------------METHODS----------------------------//
private:
    QElapsedTimer m_timer;
    bool m_isRelayOn;

    void run() override; //thread
    void hysteresis();

    float getTempSensor();
    void setRelayOn();
    void setRelayOff();

    void outputReset();

    void setFanOn();
    void setFanOff();

    //----------------------------------------------------------------//
};

#endif // WORKER_H
