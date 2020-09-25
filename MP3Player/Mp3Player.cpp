#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "config.h"
#include "service.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
//    QQuickStyle::setStyle("Fusion");

    QCoreApplication::setOrganizationName("Some organization");

    QQmlApplicationEngine engine;

    Config config;
    engine.rootContext()->setContextProperty("config", &config);
    Service service;
    engine.rootContext()->setContextProperty("service", &service);

    const QUrl url(QStringLiteral("qrc:/Mp3Player.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
