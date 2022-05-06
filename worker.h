#ifndef WORKER_H
#define WORKER_H
#include <QThread>
#include <QObject>
#include <QDebug>

class Worker : public QThread
{
    Q_OBJECT
public:
    explicit Worker();
    ~Worker()
    {
        qDebug()<<"deleted";
    }

private:
    void run() override;

signals:
    void mySignal();
};

#endif // WORKER_H
