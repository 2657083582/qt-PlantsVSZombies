import QtQuick

Item {
    x:Math.random()*1000
        AnimatedImage{
            id:suns
            focus: true
            source: "qrc:/images/interface/Sun.gif"
            visible: true
            NumberAnimation on y{
                id:fallenSun
                from: 100; to:Math.random()*800
                duration: 6000; running: true
            }
            TapHandler{
                id:collectSun
                onTapped: {
                    suns.sunCollected()
                    suns.focus=false
                    suns.visible=false
                }
            }
            function sunCollected(){
                var temp=Number(shop.sun.text)+25
                shop.sun.text=temp
            }
        }
}
