#ifndef PLANTARR_H
#define PLANTARR_H

#include <QObject>
#include <QList>
#include <QDebug>
#include <QQuickItem>
#include <QVector>

using std::array;

class PlantArr:public QObject
{
    Q_OBJECT
    QList<QQuickItem> a;

public:
    PlantArr();
    ~PlantArr();

    int *tempArr;//存储每一列最前排的植物位置,长度为5

    QVector<QQuickItem*> itemVec;//存储地图中每一格植物的容器，若没有植物则为nullptr

    Q_INVOKABLE void initTempArr();//初始化容器，将每一项设置为nullptr
    Q_INVOKABLE void initItemVec();//初始化tempArr数组,将每一项设置为0
    Q_INVOKABLE void destoryTempArr();
    Q_INVOKABLE QQuickItem* getItemVec(int i,int j);//返回给定索引值对应的item
    Q_INVOKABLE void setItemVec(int i,int j,QQuickItem* item);//设置指定位置的item
    Q_INVOKABLE int getTempArr(int i);

    Q_INVOKABLE void showItemVec();//控制台输出itemVec中的所有内容
    Q_INVOKABLE void showTempArr();//控制台输出tempArr的所有内容

signals:
    void itemVecChanged();//当itemVec改变（即调用setItemVec函数）时发出信号

    void tempArrChanged();//当tempArr改变时发出信号

    void row1Attack();
    void row2Attack();
    void row3Attack();
    void row4Attack();
    void row5Attack();


public slots:
    void updateTempArr();//更新tempArr
};

#endif // PLANTARR_H
