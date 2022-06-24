import QtQuick

Item {
    id:sunFlower
    property int hp:20
    property bool sunFlag: false
    Rectangle{
        AnimatedImage{
            id:animatedImage
            source: "/root/qt-PlantsVSZombies/planeVsZombie/images/SunFlower.gif"
            visible: false
            anchors.fill: parent
            focus: false
        }
    }
    Timer{
        interval: 3000 ; running: true
        repeat: true
        onTriggered: sunFlag=true;
    }
}
