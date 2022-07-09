#include "peaarr.h"

PeaArr::PeaArr()
{

}

QQuickItem *PeaArr::getListItem(int index)
{
    return list.at(index);
}

void PeaArr::appendListItem(QQuickItem *item)
{
    list.append(item);
}

void PeaArr::removeListAt(int index)
{
    list.removeAt(index);
}

void PeaArr::initPeaList()
{
    QList<QQuickItem*> list;
    for(int i=0;i<9;++i){
        peaVec1.append(list);
        peaVec2.append(list);
        peaVec3.append(list);
        peaVec4.append(list);
        peaVec5.append(list);
    }
}

void PeaArr::appendPeaInPeaVec(int row,int index, QQuickItem *item)
{
    switch(row){
    case 1:peaVec1[index].append(item);
        break;
    case 2:peaVec2[index].append(item);
        break;
    case 3:peaVec3[index].append(item);
        break;
    case 4:peaVec4[index].append(item);
        break;
    case 5:peaVec5[index].append(item);
        break;
    }
}

QQuickItem *PeaArr::getPeaInPeaVecAt(int row, int index, int x)
{
    switch(row){
    case 1:return peaVec1[index].at(x);
    case 2:return peaVec2[index].at(x);
    case 3:return peaVec3[index].at(x);
    case 4:return peaVec4[index].at(x);
    case 5:return peaVec5[index].at(x);
    }
    return nullptr;
}

void PeaArr::removePeaInPeaVecAt(int row, int index, int x)
{
    switch(row){
    case 1:peaVec1[index].removeAt(x);
        break;
    case 2:peaVec2[index].removeAt(x);
        break;
    case 3:peaVec3[index].removeAt(x);
        break;
    case 4:peaVec4[index].removeAt(x);
        break;
    case 5:peaVec5[index].removeAt(x);
        break;
    }
}

void PeaArr::setPeaInPeaVecAt(int row, int index, int x, QQuickItem *item)
{
    switch(row){
    case 1:peaVec1[index].replace(x,item);
        break;
    case 2:peaVec2[index].replace(x,item);
        break;
    case 3:peaVec3[index].replace(x,item);
        break;
    case 4:peaVec4[index].replace(x,item);
        break;
    case 5:peaVec5[index].replace(x,item);
        break;
    }
}

int PeaArr::lengthOfPeaList(int row, int index)
{
    switch(row){
    case 1:return peaVec1[index].length();
    case 2:return peaVec2[index].length();
    case 3:return peaVec3[index].length();
    case 4:return peaVec4[index].length();
    case 5:return peaVec5[index].length();
    }
    return -1;
}

bool PeaArr::peaVecIsEmpty(int row,int index)
{
    switch(row){
    case 1:return peaVec1[index].isEmpty();
    case 2:return peaVec2[index].isEmpty();
    case 3:return peaVec3[index].isEmpty();
    case 4:return peaVec4[index].isEmpty();
    case 5:return peaVec5[index].isEmpty();
    }
    return false;
}




