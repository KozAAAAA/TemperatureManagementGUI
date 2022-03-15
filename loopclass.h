#ifndef LOOPCLASS_H
#define LOOPCLASS_H

#include <QObject>

class LoopClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString someVar READ someVar WRITE setSomeVar NOTIFY someVarChanged)
public:
    explicit LoopClass(QObject* parent = nullptr);
    QString someVar();
signals:
    void someVarChanged();
public slots:
    void setSomeVar(QString);

public:
    QString m_someVar;
};

#endif // LOOPCLASS_H
