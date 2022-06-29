#ifndef MOWERARR_H
#define MOWERARR_H

#include <QObject>
#include <QQuickItem>
#include <QList>

class MowerArr: public QObject
{
    Q_OBJECT

public:
    MowerArr();

    QList<QQuickItem *> mowerList;

    Q_INVOKABLE void appendMowerList(QQuickItem *item);
    Q_INVOKABLE QQuickItem* getMower(int index);

};

#endif // MOWERARR_H
