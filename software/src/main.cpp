#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "maingui.h"



int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

#ifdef __arm__
    wiringPiSetup();
    pinMode(RELAY, OUTPUT);
    pinMode(FAN, OUTPUT);
    auto exitFunc = [](){digitalWrite(RELAY,LOW);
                         digitalWrite(FAN,LOW);
                         qDebug()<< "SAFETY HANDLER: evoked";};
#else
    auto exitFunc = [](){qDebug() << "SAFETY HANDLER: evoked";};
#endif

    std::atexit(exitFunc);

    MainGui* _MainGui = new MainGui;

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("_cppBackend",_MainGui);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    int ret;
    try
    {
        ret = app.exec();
    }
    catch(...)
    {
        exitFunc();
        qCritical() << "ERROR: Main crashed";
        return EXIT_FAILURE;
    }

    return ret;



}
