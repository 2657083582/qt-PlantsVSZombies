#include "peaarr.h"

PeaArr::PeaArr()
{

}

void PeaArr::appendPeaList(int i, QQuickItem *item)
{
    switch(i){
    case 1:{
        peaList1.append(item);
        break;
        }
    case 2:{
        peaList2.append(item);
        break;
        }
    case 3:{
        peaList3.append(item);
        break;
        }
    case 4:{
        peaList4.append(item);
        break;
        }
    case 5:{
        peaList5.append(item);
        break;
        }
    }
    emit appendPea();
}

QQuickItem *PeaArr::getPea(int i, int index)
{
    switch(i){
    case 1:{
        return peaList1.at(index);
        }
    case 2:{
        return peaList2.at(index);
        }
    case 3:{
        return peaList3.at(index);
        }
    case 4:{
        return peaList4.at(index);
        }
    case 5:{
        return peaList5.at(index);
        }
    }
    return nullptr;
}

void PeaArr::swapTwoPeasInPeaList(int i, int index1,int index2)
{
    switch(i){
    case 1:{
        peaList1.swapItemsAt(index1,index2);
        break;
        }
    case 2:{
        peaList2.swapItemsAt(index1,index2);
        break;
        }
    case 3:{
        peaList3.swapItemsAt(index1,index2);
        break;
        }
    case 4:{
        peaList4.swapItemsAt(index1,index2);
        break;
        }
    case 5:{
        peaList5.swapItemsAt(index1,index2);
        break;
        }
    }
    emit swapPea();
}

int PeaArr::lengthOfPeaList(int i)
{
    switch(i){
    case 1:{
        return peaList1.length();
        }
    case 2:{
        return peaList2.length();
        }
    case 3:{
        return peaList3.length();
        }
    case 4:{
        return peaList4.length();
        }
    case 5:{
        return peaList5.length();
        }
    }
    return -1;
}


