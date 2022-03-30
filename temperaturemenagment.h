#ifndef TEMPERATUREMENAGMENT_H
#define TEMPERATUREMENAGMENT_H

#include <QObject>

class TemperatureMenagment : public QObject
{
    Q_OBJECT
public:

    explicit TemperatureMenagment(QObject *parent = nullptr);

    Q_INVOKABLE void setInputParam (const QString& parameter, const uint16_t& value,const uint8_t& index);
    Q_INVOKABLE void setInputParam (const QString& parameter, const uint16_t& value);

    Q_INVOKABLE int getInputParam(int index);


private:
    std::vector<uint16_t> m_tempInputVector;
    std::vector<uint16_t> m_timeInputVector;
    uint8_t m_loopInput;
};

#endif // TEMPERATUREMENAGMENT_H
