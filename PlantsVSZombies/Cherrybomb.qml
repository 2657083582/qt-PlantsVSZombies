import QtQuick

Item {
     //property alias timer: timer

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
         interval: 1500 ; running: true
         repeat: false
         onTriggered: animatedImage.source="qrc:/images/plants/Boom.gif"
     }
     function isAttacked(zombieAtk){
         if(zombieAtk)
             hp-=zombieAtk
     }
}
