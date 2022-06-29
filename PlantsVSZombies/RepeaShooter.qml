import QtQuick

Item {
    id:rePeaShooter
    property int hp:300
    property bool createPeaFlag: false
    property bool canShot:true
    property string name: "repeatShooter"
    AnimatedImage{
        id:animatedImage
        source: "qrc:/images/plants/Repeater.gif"
        visible:true
        anchors.fill: parent
    }

    function isAttacked(zombieAtk){
        if(zombieAtk)
            hp-=zombieAtk
    }

    function createdoublePeas() {
        var newDoublePea = Qt.createQmlObject('Pea{x: 123 * 0.75 * 0.65; y: 144 * 0.1 * 0.5}', rePeaShooter);
    }

    Timer {
        id: createdoublePea
        interval: 3000; running: true; repeat: true
        onTriggered: {
            if(createPeaFlag === true) {
                createdoublePeas();
                second.running=true
            }
        }

    }
    Timer{
        id:second
        interval: 2800; running:true; repeat:true
        onTriggered: {
            if(createPeaFlag === true){
                createdoublePeas();
                second.running=false
            }
        }
    }
}
