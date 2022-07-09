//豌豆类
//用于管理豌豆射手发射的子弹

#ifndef PEAARR_H
#define PEAARR_H

#include <QObject>
#include <QQuickItem>
#include <QVector>
#include<QList>

class PeaArr:public QObject
{
    Q_OBJECT
public:
    PeaArr();

    QVector<QList<QQuickItem*>>peaVec1;
    QVector<QList<QQuickItem*>>peaVec2;
    QVector<QList<QQuickItem*>>peaVec3;
    QVector<QList<QQuickItem*>>peaVec4;
    QVector<QList<QQuickItem*>>peaVec5;

    QList<QQuickItem*> list;

//    QList<QQuickItem*> peaList1;
//    QList<QQuickItem*> peaList2;
//    QList<QQuickItem*> peaList3;
//    QList<QQuickItem*> peaList4;
//    QList<QQuickItem*> peaList5;

    Q_INVOKABLE QQuickItem* getListItem(int index);
    Q_INVOKABLE void appendListItem(QQuickItem *item);
    Q_INVOKABLE void removeListAt(int index);

    Q_INVOKABLE void initPeaList();
    Q_INVOKABLE void appendPeaInPeaVec(int row,int index,QQuickItem *item);
    Q_INVOKABLE QQuickItem* getPeaInPeaVecAt(int row,int index,int x);
    Q_INVOKABLE void removePeaInPeaVecAt(int row,int index,int x);
    Q_INVOKABLE void setPeaInPeaVecAt(int row,int index,int x,QQuickItem*item);
    Q_INVOKABLE int lengthOfPeaList(int row,int index);

    Q_INVOKABLE bool peaVecIsEmpty(int row,int index);


signals:
    void appendPeaAtPeaVec1();
    void appendPeaAtPeaVec2();
    void appendPeaAtPeaVec3();
    void appendPeaAtPeaVec4();
    void appendPeaAtPeaVec5();

    void removePea();


};

#endif // PEAARR_H
