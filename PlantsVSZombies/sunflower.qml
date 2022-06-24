import QtQuick

Item {
    id:sunFlower
    property int hp:300
    property bool sunFlag: false
    Rectangle{
        AnimatedImage{
            id:animatedImage
            source: "qrc:/images/SunFlower.gif"
            visible:true
        }
    }
    Timer{
        interval: 3000 ; running: true
        repeat: true
        onTriggered: sunFlag=true;
    }
}
