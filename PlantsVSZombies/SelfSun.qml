import QtQuick

Item {
    x:parent.width-10
    NumberAnimation on y{
        target:selfSun
        from:100; to:parent.height
        duration: 5000; running :true
    }
    AnimatedImage{
        id:selfSun
        anchors.fill:parent
        source: "qrc:/images/interface/Sun.gif"
        visible: true
        focus:true
        function selfSunCollect(){
            var temp=Number(shop.sun.text)+25
            shop.sun.text=temp
        }

    }
    TapHandler{
        id:collectSelfSun
        onTapped: {
            selfSun.selfSunCollect()
            selfSun.focus=false
            selfSun.visible=false
        }
    }
}
