#ifndef LOOPCLASS_H
#define LOOPCLASS_H

#include <QObject>

class LoopClass : public QObject
{
    Q_OBJECT
public:
    explicit LoopClass(QObject *parent = nullptr);

signals:
    void valueChanged(QString s);

public slots:
    void changeValue(QString s);
};

#endif // LOOPCLASS_H
