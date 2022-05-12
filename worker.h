#ifndef WORKER_H
#define WORKER_H
#include <QThread>
#include <QObject>
#include <QDebug>
#include <QFile>

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

private:

    bool m_threadActive;

    const std::vector<quint16> m_tempInputVector;
    const std::vector<quint16> m_timeInputVector;
    const quint8 m_loopInput;

    float m_currentTemp;
    quint16 m_currentTime;
    quint8 m_currentLoop;
    quint8 m_currentBlock;

    void run() override;
    float getTempSensor();
    void setRelayOn();
    void setRelayOff();
    void outputReset();

public slots:
    void setThreadNotActive();

signals:
    void currentTemp(quint16);
    void currentTime(quint16);
    void currentLoop(quint8);
    void currentBlock(quint8);
};

#endif // WORKER_H
