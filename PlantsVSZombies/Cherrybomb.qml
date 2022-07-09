//樱桃炸弹
import QtQuick

Item {
     //property alias timer: timer
     property bool canShot:false
    property string name: "cherryBomb"
     signal testsignal()
     id:cherryBomb
     property int hp:300
     property int damage:1800
     //Rectangle{
         AnimatedImage{
             id:animatedImage
             source:"qrc:/images/plants/CherryBomb.gif"
             visible:true
         }
     //}
     Timer{
         id:timer
         interval: 800; running: true
         repeat: false
         onTriggered: {
             animatedImage.source="qrc:/images/plants/Boom.gif"
             timer2.running=true
         }
     }
     Timer{
         id:timer2
         interval:600; running:false
         repeat: false
         onTriggered: {
             cherryBomb.hp=0
             cherryBomb.visible=false//爆炸后隐藏视图但未销毁对象
             cherryBomb.testsignal()
         }
     }

     function isAttacked(zombieAtk){
         if(zombieAtk)
             hp-=zombieAtk
     }
}
