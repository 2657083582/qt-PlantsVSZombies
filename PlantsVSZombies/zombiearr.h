//僵尸数组类，用于管理僵尸
#ifndef ZOMBIEARR_H
#define ZOMBIEARR_H

#include <QObject>
#include <QQuickItem>
#include <QList>

class ZombieArr:public QObject
{
    Q_OBJECT
public:
    ZombieArr();
    ~ZombieArr(){};

    QList<QQuickItem*> zombieList1;
    QList<QQuickItem*> zombieList2;
    QList<QQuickItem*> zombieList3;
    QList<QQuickItem*> zombieList4;
    QList<QQuickItem*> zombieList5;

    //Q_INVOKABLE void initZombieLists();
    Q_INVOKABLE void appendZombieList(int i,QQuickItem *item);
    Q_INVOKABLE QQuickItem* getZombie(int i,int index);
    Q_INVOKABLE void removeZombieList(int i,int index);
    Q_INVOKABLE void swapTwoZombiesInZombieList(int i,int index1,int index2);
    Q_INVOKABLE void zombieExist();
    Q_INVOKABLE int lengthOfZombieList(int i);
    Q_INVOKABLE bool zombieListIsEmpty(int i);

signals:
    void appendZombie();
    void removeZombie();
    void swapZombie();
    void row1hasZombie();
    void row2hasZombie();
    void row3hasZombie();
    void row4hasZombie();
    void row5hasZombie();

};

#endif // ZOMBIEARR_H
