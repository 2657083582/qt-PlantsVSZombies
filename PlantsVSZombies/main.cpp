#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"plantarr.h"
#include"zombiearr.h"
#include"peaarr.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<PlantArr>("an.qt.PlantArr",1,0,"PlantArr");
    qmlRegisterType<ZombieArr>("an.qt.ZombieArr",1,0,"ZombieArr");
    qmlRegisterType<PeaArr>("an.qt.PeaArr",1,0,"PeaArr");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/planeVsZombie/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
