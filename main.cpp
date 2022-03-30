#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "loopclass.h"
#include "temperaturemenagment.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif



    LoopClass loopclass;
    TemperatureMenagment* temperatureMenagment = new TemperatureMenagment;

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loopclass",&loopclass);
    engine.rootContext()->setContextProperty("_cppBackend",temperatureMenagment);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
            return -1;

    return app.exec();

}
