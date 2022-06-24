import QtQuick

Item {
    id:peaShooter
    property int hp:300
    Rectangle{
        AnimatedImage{
            id:animatedImage
            source: "qrc:/images/PeaShooter.gif"
            visible:true
        }
    }
    Timer{
        interval: 1400 ; running: true
        repeat: true;
//        onTriggered: hasZombie   //有zombie在同一y轴
    }
}
