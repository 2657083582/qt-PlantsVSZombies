import QtQuick

Item {
    property alias shop: shop
    property int order: -1

    function addCard(){
        var filepaths=[
                "./images/SunFlower.png","./images/Peashooter.png",
                "./images/PotatoMine.png","./images/Repeater.png",
                "./images/SnowPea.png","./images/CherryBomb.png",
                "./images/WallNut.png"];
        var costs=["50","100","25","200","175","150","50"];

        listModel.clear();
        for(var i=0;i<10;++i){
            if(i<7) listModel.append({"path":filepaths[i],"cost":costs[i],"index":i});
            else    listModel.append({"path":filepaths[i%7],"cost":costs[i%7],"index":i})
            //console.log(filepaths[i])
        }
    }

    id:shop
    width: 446*2.4
    height: 87*1.6
    Image{
        anchors.fill: parent
        fillMode: Image.Stretch
        source: "file:///root/study/qt/PVZ-master/images/Shop.png"
        Component.onCompleted: addCard()

        Text{
            id:sun
            text:"2000"
            font.pixelSize: 30
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.bottomMargin:5
            anchors.leftMargin: 40
            color:"#FFFFFF"
            TapHandler{
                onTapped: console.log("tapped")
            }
        }

    }
    Rectangle{
        width: 446*2+10
        height: 87*1.4
        anchors.left: parent.left
        anchors.top:parent.top
        anchors.leftMargin: 160
        anchors.topMargin: 7
        color:"transparent"
        ListView{
            id:listView
            anchors.fill: parent
            orientation: ListView.Horizontal
            delegate: Card{id:card}

            model:listModel
        }
    }

    ListModel{
        id:listModel

    }


}
