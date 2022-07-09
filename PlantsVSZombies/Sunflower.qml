//向日葵
import QtQuick

Item {
    id:sunFlower
    anchors.fill: parent
    property int hp:300
    property bool sunFlag: false
    property bool canShot:false
    property string name: "sunFlower"
//    signal sendSelfSun()
        AnimatedImage{
            anchors.fill: parent
            id:animatedImage
            source: "qrc:/images/plants/SunFlower.gif"
            visible:true
        }
    function isAttacked(zombieAtk){
        hp-=zombieAtk
    }

    SelfSun{
        id:tmp
        visible: false
        focus:false
        onSendSelfSun: {
           tmp.focus=true
           tmp.visible=true
        }
    }

//    Timer{
//        function createSun(){
//            var sun=Qt.createQmlObject('SelfSun{anchors.top:parent.top;anchors.left:parent.left}',sunFlower)
//        }
//        id:selfSunTimer
//        interval: 4000
//        repeat: true
//        running:true
////        onRunningChanged: selfSunTimer.start()
//        onTriggered:{
//            selfSunTimer.createSun()
//            console.log("Sunflower")
//        }
//    }


}

