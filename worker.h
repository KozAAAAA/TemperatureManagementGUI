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

    explicit Worker(const std::vector<uint16_t>&,
                    const std::vector<uint16_t>&,
                    const uint8_t&);
    ~Worker();

private:

    bool m_threadActive;

    const std::vector<uint16_t> m_tempInputVector;
    const std::vector<uint16_t> m_timeInputVector;
    const uint8_t m_loopInput;

    uint16_t m_currentTemp;
    uint16_t m_currentTime;
    uint8_t m_currentLoop;
    uint8_t m_currentBlock;

    void run() override;
    float getTempSensor();
    void setRelayOn();
    void setRelayOff();
    void outputReset();

public slots:
    void setThreadNotActive();

signals:
    void currentTemp(int);
    void currentTime(int);
    void currentLoop(int);
    void currentBlock(int);
};

#endif // WORKER_H
