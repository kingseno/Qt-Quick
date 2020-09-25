#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "handlekey.h"
#include "data.h"
#include "CustomDefine.h"
#include "hardwareemulator.h"
#include "configuration.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<HandleKey>("BackEnd", 1, 0, "HandleKey");
    qmlRegisterType<Data>("BackEnd", 1, 0, "Data");
    qmlRegisterType<CustomDefine>("BackEnd", 1, 0, "Custom");
    qmlRegisterType<HardwareEmulator>("BackEnd", 1, 0, "Hardware");
    qmlRegisterType<Configuration>("BackEnd", 1, 0, "Config");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
