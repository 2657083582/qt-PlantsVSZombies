#include "mowerarr.h"

MowerArr::MowerArr()
{

}

void MowerArr::appendMowerList(QQuickItem *item)
{
    mowerList.append(item);
}

QQuickItem *MowerArr::getMower(int index)
{
    if(index < 5 && index >= 0) {

        int i;
        return mowerList.at(index);
    }else {
        return nullptr;
    }
}
