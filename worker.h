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

    explicit Worker();
    ~Worker();

private:
    bool m_threadActive;
    float m_tempSensor;

    void run() override;
    float getTempSensor();
    void setRelayOn();
    void setRelayOff();

public slots:
    void setThreadNotActive();
};

#endif // WORKER_H
