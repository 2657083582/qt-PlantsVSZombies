/******************************
 项目名称：植物大战僵尸
 时间：2022.7.9
  *****************************/


#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"plantarr.h"
#include"zombiearr.h"
#include"peaarr.h"
#include"mowerarr.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<PlantArr>("an.qt.PlantArr",1,0,"PlantArr");
    qmlRegisterType<ZombieArr>("an.qt.ZombieArr",1,0,"ZombieArr");
    qmlRegisterType<PeaArr>("an.qt.PeaArr",1,0,"PeaArr");
    qmlRegisterType<MowerArr>("an.qt.MowerArr",1,0,"MowerArr");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/planeVsZombie/main.qml"_qs);
    //const QUrl url(u"qrc:/planeVsZombie/GameWindow.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
