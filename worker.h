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

class Worker : public QThread
{
    Q_OBJECT
public:
    explicit Worker(const std::vector<quint16>&,
                    const std::vector<quint16>&,
                    const quint8&);
    ~Worker();

    //------------------------------INPUT-----------------------------//
private:
    const std::vector<quint16> m_tempInputVector;
    const std::vector<quint16> m_timeInputVector;
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
    void relayIsOn();
    void relayIsOff();
    //----------------------------------------------------------------//

    //-----------------------------METHODS----------------------------//
private:
    QElapsedTimer m_timer;
    bool m_isRelayOn;

    void run() override; //thread

    float getTempSensor();
    void setRelayOn();
    void setRelayOff();
    void outputReset();
    void pid();
    //----------------------------------------------------------------//
};

#endif // WORKER_H
