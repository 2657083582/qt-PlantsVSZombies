#include "plantarr.h"

PlantArr::PlantArr()
{

}

PlantArr::~PlantArr()
{
    destoryTempArr();
}


void PlantArr::initTempArr()
{
    tempArr=new int[5];
    for(int i=0;i<5;++i)
        tempArr[i]=-1;
}

void PlantArr::initItemVec()
{
    for(int i=0;i<5;++i)
        for(int j=0;j<9;++j)
            itemVec.append(nullptr);
}



void PlantArr::destoryTempArr()
{
    delete[] tempArr;
}



QQuickItem* PlantArr::getItemVec(int i, int j)
{
    return itemVec[i*9+j];
}

void PlantArr::setItemVec(int i ,int j, QQuickItem *item)
{
    itemVec[i*9+j]=item;
    emit itemVecChanged();
}

int PlantArr::getTempArr(int i)
{
    return tempArr[i];
}

void PlantArr::showItemVec()
{
    for(int i=0;i<5;i++){
        for(int j=0;j<9;j++){
            if(itemVec[i*9+j]!=nullptr)
                qDebug()<<"1";
            else
                qDebug()<<"0";
        }
    qDebug()<<"\n";
    }
}

void PlantArr::showTempArr(){
    for(int i=0;i<5;i++)
        qDebug()<<tempArr[i]<<" ";
}

void PlantArr::updateTempArr()
{
    bool flag=false;
    for(int i=0;i<5;++i)
    {
        int j=8;
        for(;j>=0;j--)
        {
            if(itemVec[i*9+j]!=nullptr){
                tempArr[i]=j;
                flag=true;
                break;
            }
        }
        if(j==-1){
            tempArr[i]=-1;
            flag=true;
        }
    }
    if(flag)
        emit tempArrChanged();

}


