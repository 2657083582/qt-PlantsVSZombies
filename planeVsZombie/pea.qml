import QtQuick

Image{
    id: pea
    property bool peaFlag
    x: parent.width - 5
    visible: true
    source: {if(peaFlag) return "/root/qt-PlantsVSZombies/planeVsZombie/images/Pea.gif"; else return ""}
    NumberAnimation on x {
        id: shoot
        duration: 2000
        from: parent.width - 5
        to: 900;
        onStarted: {pea.visible = true}
        onStopped: {pea.visible = true; shoot.restart(); flag = true}
    }
    function shootRestart(){
        pea.visible = false
    }
    //击中效果source:/root/qt-PlantsVSZombies/planeVsZombie/images/PeaHit.gif
}
