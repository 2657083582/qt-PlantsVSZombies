import QtQuick

Rectangle{
    //property alias cardList: cardList
    function addCard(){
        var filepaths=[
                "qrc:/images/plants/SunFlower.png","qrc:/images/plants/PeaShooter.png",
                "qrc:/images/plants/PotatoMine.png","qrc:/images/plants/Repeater.png",
                "qrc:/images/plants/SnowPea.png","qrc:/images/plants/CherryBomb.png",
                "qrc:/images/plants/WallNut.png"];
        var costs=["50","100","25","200","175","150","50"];
        var names=["sunFlower","peaShooter","potatoMine","Reapter","snowPea","cherryBomb","wallNut"];
        listModel.clear();
        for(var i=0;i<7;++i){
            listModel.append({"name":names[i],"path":filepaths[i],"cost":costs[i]});
        }
    }

    //ListModel{id:cardList}

    width: 480*1.2
    height: 600*1.2-80
    color: "transparent"
    Rectangle{

        id:topRect
        width: parent.width
        height: parent.height*0.92
        color:"transparent"
        Image {
            source: "qrc:/images/interface/SeedChooser_Background.png"
            anchors.fill: parent
            Component.onCompleted: addCard()
        }
        Rectangle{
            width: topRect.width*0.95
            height: topRect.height*0.9
            anchors.top:topRect.top
            anchors.left: topRect.left
            anchors.topMargin: topRect.height*0.065
            anchors.leftMargin: topRect.width*0.025
            color: "transparent"
            GridView{
                //property int num: 0
                id:gridView
                cellWidth: 90
                cellHeight: 120
                anchors.fill: parent
                model:listModel
                delegate: Card{
                    id:card
                    property bool choosed
                    onStateChanged: {
                        choosed=!choosed//植物卡片的状态改变时，choosed属性改变
                    }
                    Component.onCompleted: {
                        choosed=false
                        shop.listModel.clear()
                    }
                    onChoosedChanged: {
                        if(choosed){//当植物被选择时，添加进卡槽
                            var i=0,temp
                            //检测是否已经被选过了，如过未选择过则添加，否则不能添加
                            for(;i<shop.listModel.count;++i){
                                temp=shop.listModel.get(i).name
                                if(temp===card.name)
                                    break;
                            }
                            if(i>=shop.listModel.count){
                                shop.listModel.append({ "name":card.name,
                                                        "path":card.path,
                                                        "cost":card.cost,
                                                        "test":shop.num })
                                //console.log("index"+shop.listModel.get(shop.num).index)
                                shop.num++
                            }

                        }
                        else{
                            //若choosed为false时，将卡片从卡槽中删除
                            for(i=0;i<shop.listModel.count;++i){//判断删除的是第几张卡片
                                temp=shop.listModel.get(i).name
                                if(temp===card.name)
                                {
                                    //console.log("remove:"+i)
                                    break;
                                }
                            }
                            shop.listModel.remove(i,1)
                            shop.num--

                            for(var j=i;j<shop.listModel.count;++j){
                                shop.listModel.set(j,{"test":j})

                            }
                        }
                    }
                }
            }
        }

        ListModel{id:listModel}
    }

}
