#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "config.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Config>("BackEnd", 1, 0, "Config");

    QQmlApplicationEngine engine;

//    Config config;
//    engine.rootContext()->setContextProperty("setContext", &config);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
