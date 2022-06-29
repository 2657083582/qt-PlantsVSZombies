import QtQuick

Item {
     id:wallNut
     property int hp:4000
     property bool canShot:false
     //Rectangle{
         AnimatedImage{
             id:animatedImage
             source: "qrc:/images/plants/WallNut.gif"
             visible:true
             anchors.fill: parent
         }
     //}
     onHpChanged: {
         if(hp<4000*2/3&&hp>4000/3)
             animatedImage.source="qrc:/images/plants/WallNutCracked1.gif"
         else if(hp>0&&hp<4000/3)
             animatedImage.source="qrc:/images/plants/WallNutCracked2.gif"
     }
     function isAttacked(zombieAtk){
         if(zombieAtk)
             hp-=zombieAtk
     }
//     function Death(hp){
//         if(hp<=0)
//             delete wallNut
//     }
}
