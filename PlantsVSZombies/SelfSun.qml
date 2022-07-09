//向日葵生产的阳光
import QtQuick

Item {
//    x:parent.width-10
//    NumberAnimation on y{
//        target:selfSun
//        from:100; to:parent.height
//        duration: 5000; running :true
//    }
    id:root
    width: 100
    height: 100
    focus:false
    signal sendSelfSun()
    AnimatedImage{
        id:selfSun
        anchors.fill:parent
        source: "qrc:/images/interface/Sun.gif"

        function selfSunCollect(){
            var temp=Number(shop.sun.text)+25
            shop.sun.text=temp
            root.focus=false
            root.visible=false
        }
    }
    TapHandler{
        id:collectSelfSun
        onTapped: {
            selfSun.selfSunCollect()
        }
    }
    Timer{
        interval:4000
        running:true
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            emit:sendSelfSun();
        }

    }
}
