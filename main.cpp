#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "loopclass.h"
#include "maingui.h"

#include <QFontDatabase>


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif



    MainGui* temperatureMenagment = new MainGui;

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("_cppBackend",temperatureMenagment);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
            return -1;

    return app.exec();

}
