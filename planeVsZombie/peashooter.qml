import QtQuick

Item {
    id:peaShooter
    property int hp:60
    Rectangle{
        AnimatedImage{
            id:animatedImage
            source: "/root/qt-PlantsVSZombies/planeVsZombie/images/PeaShooter.gif"
            visible: false
            anchors.fill: parent
            focus: false
        }
    }
    Timer{
        interval: 2000 ; running: true
        repeat: true;
//        onTriggered: hasZombie   //有zombie在同一y轴
    }
}
