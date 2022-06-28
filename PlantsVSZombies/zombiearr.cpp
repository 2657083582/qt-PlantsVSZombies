#include "zombiearr.h"

ZombieArr::ZombieArr()
{

}

void ZombieArr::appendZombieList(int i, QQuickItem *item)
{
    switch(i){
    case 1:{
        zombieList1.append(item);
        break;
        }
    case 2:{
        zombieList2.append(item);
        break;
        }
    case 3:{
        zombieList3.append(item);
        break;
        }
    case 4:{
        zombieList4.append(item);
        break;
        }
    case 5:{
        zombieList5.append(item);
        break;
        }
    }
    emit appendZombie();

}

QQuickItem *ZombieArr::getZombie(int i, int index)
{
    switch(i){
    case 1:{
        return zombieList1.at(index);
        }
    case 2:{
        return zombieList2.at(index);
        }
    case 3:{
        return zombieList3.at(index);
        }
    case 4:{
        return zombieList4.at(index);
        }
    case 5:{
        return zombieList5.at(index);
        }
    }
    return nullptr;
}

void ZombieArr::removeZombieList(int i, int index, QQuickItem *item)
{
    switch(i){
    case 1:{
        zombieList1.removeAt(index);
        break;
        }
    case 2:{
        zombieList2.removeAt(index);
        break;
        }
    case 3:{
        zombieList3.removeAt(index);
        break;
        }
    case 4:{
        zombieList4.removeAt(index);
        break;
        }
    case 5:{
        zombieList5.removeAt(index);
        break;
        }
    }
    emit removeZombie();
}

void ZombieArr::swapTwoZombiesInZombieList(int i, int index1, int index2)
{
    switch(i){
    case 1:{
        zombieList1.swapItemsAt(index1,index2);
        break;
        }
    case 2:{
        zombieList2.swapItemsAt(index1,index2);
        break;
        }
    case 3:{
        zombieList3.swapItemsAt(index1,index2);
        break;
        }
    case 4:{
        zombieList4.swapItemsAt(index1,index2);
        break;
        }
    case 5:{
        zombieList5.swapItemsAt(index1,index2);
        break;
        }
    }
    emit swapZombie();
}

void ZombieArr::zombieExist(int i)
{
    bool flag=false;
    switch(i){
    case 1:{if(!zombieList1.isEmpty())
            emit row1hasZombie();
    }
    case 2:{if(!zombieList2.isEmpty())
            emit row2hasZombie();
        }
    case 3:{if(!zombieList3.isEmpty())
            emit row3hasZombie();
    }
    case 4:{if(!zombieList4.isEmpty())
            emit row4hasZombie();
    }
    case 5:{if(!zombieList5.isEmpty())
            emit row4hasZombie();
        }
    }
}
