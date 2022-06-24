import QtQuick

Item {
     id:cherryBomb
     property int hp:300
     property int damage:1800
     Rectangle{
         AnimatedImage{
             id:animatedImage
             source:"qrc:/images/CherryBomb.gif"
             visible:true
         }
     }
     Timer{
         interval: 1500 ; running: true
         repeat: false
         onTriggered: animatedImage.source="qrc:/images/Boom.gif"
     }
}
