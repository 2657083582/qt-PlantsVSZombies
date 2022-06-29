#ifndef PEAARR_H
#define PEAARR_H

#include <QObject>
#include <QQuickItem>
#include <QList>

class PeaArr:public QObject
{
    Q_OBJECT
public:
    PeaArr();

    QList<QQuickItem*> peaList1;
    QList<QQuickItem*> peaList2;
    QList<QQuickItem*> peaList3;
    QList<QQuickItem*> peaList4;
    QList<QQuickItem*> peaList5;

    Q_INVOKABLE void appendPeaList(int i,QQuickItem *item);
    Q_INVOKABLE QQuickItem* getPea(int i,int index);
    Q_INVOKABLE void swapTwoPeasInPeaList(int i,int index1,int index2);
    Q_INVOKABLE int lengthOfPeaList(int i);

signals:
    void appendPea();
    void removePea();
    void swapPea();
//    void row1hasPea();
//    void row2hasPea();
//    void row3hasPea();
//    void row4hasPea();
//    void row5hasPea();

};

#endif // PEAARR_H
