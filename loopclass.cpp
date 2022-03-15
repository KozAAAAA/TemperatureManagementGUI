#include "loopclass.h"

LoopClass::LoopClass(QObject *parent)
    : QObject{parent}
{

}

void LoopClass::changeValue(QString s)
{
    emit valueChanged(s);
}
