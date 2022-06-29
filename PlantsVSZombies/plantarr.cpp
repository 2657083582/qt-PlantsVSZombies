#include "plantarr.h"

PlantArr::PlantArr()
{

}

PlantArr::~PlantArr()
{
    //destoryArr();
    destoryTempArr();
}

//void PlantArr::initArr()
//{
//    arr=new int*[5];
//    for(int i=0;i<5;++i)
//    {
//        arr[i]=new int[9];
//        for(int j=0;j<9;++j)
//            arr[i][j]=0;
//    }
//}

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

//void PlantArr::destoryArr()
//{
//    for(int i=0;i<5;i++)
//        delete [] arr[i];
//    delete[] arr;
//}

void PlantArr::destoryTempArr()
{
    delete[] tempArr;
}

//void PlantArr::setArr(int i, int j,int para)
//{
//    arr[i][j]=para;
//    emit arrChanged();
//}

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

//void PlantArr::showArr()
//{
//    for(int i=0;i<5;i++){
//        for(int j=0;j<9;j++){
//            qDebug()<<arr[i][j]<<" ";
//        }
//        qDebug()<<"\n";
//    }
//}


void PlantArr::showTempArr(){
    for(int i=0;i<5;i++)
        qDebug()<<tempArr[i]<<" ";
}

void PlantArr::updateTempArr()
{
    bool flag=false;
    for(int i=0;i<5;++i)
    {
        for(int j=8;j>=0;j--)
        {
            if(itemVec[i*9+j]!=nullptr){
                tempArr[i]=j;
                flag=true;
                break;
            }
        }
    }
    if(flag)
        emit tempArrChanged();
}


