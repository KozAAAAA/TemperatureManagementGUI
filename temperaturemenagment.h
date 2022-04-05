#ifndef TEMPERATUREMENAGMENT_H
#define TEMPERATUREMENAGMENT_H

#include <QObject>

class TemperatureMenagment : public QObject
{
    Q_OBJECT
public:
    explicit TemperatureMenagment(QObject *parent = nullptr);


        //------------------------------INPUT-----------------------------//
public:
    Q_INVOKABLE void setInputParam (const QString& parameter, const int& value,const int& index);
    Q_INVOKABLE void setInputParam (const QString& parameter, const int& value);

    //debug:
    Q_INVOKABLE void printInputParam();

private:
    std::vector<uint16_t> m_tempInputVector;
    std::vector<uint16_t> m_timeInputVector;
    uint8_t m_loopInput;
        //----------------------------------------------------------------//



        //-----------------------------OUTPUT-----------------------------//
public:
    Q_PROPERTY(int tempOutput READ getTempOutput WRITE setTempOutput NOTIFY tempOutputChanged)
    Q_PROPERTY(int timeOutput READ getTimeOutput WRITE setTimeOutput NOTIFY timeOutputChanged)
    Q_PROPERTY(int loopOutput READ getLoopOutput WRITE setLoopOutput NOTIFY loopOutputChanged)
    Q_PROPERTY(int blockOutput READ getBlockOutput WRITE setBlockOutput NOTIFY blockOutputChanged)

    int getTempOutput();
    int getTimeOutput();
    int getLoopOutput();
    int getBlockOutput();

public slots:
    void setTempOutput(const uint16_t& newTemp);
    void setTimeOutput(const uint16_t& newTime);
    void setLoopOutput(const uint8_t& newLoop);
    void setBlockOutput(const uint8_t& newBlock);

private:
    uint16_t m_tempOutput;
    uint16_t m_timeOutput;
    uint8_t m_loopOutput;
    uint8_t m_blockOutput;

signals:
    void tempOutputChanged();
    void timeOutputChanged();
    void loopOutputChanged();
    void blockOutputChanged();
        //----------------------------------------------------------------//
};

#endif // TEMPERATUREMENAGMENT_H
