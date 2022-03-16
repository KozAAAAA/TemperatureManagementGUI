#include "loopclass.h"

LoopClass::LoopClass(QObject *parent)
    : QObject{parent} , m_someVar("123")
{

}

QString LoopClass::getSomeVar()
{
    return m_someVar;
}

void LoopClass::setSomeVar(QString newVar)
{
    if (m_someVar != newVar)
    {
        m_someVar = newVar;
        emit someVarChanged();
    }
}
