import QtQuick

Item {
    id:snowPeaShooter
    property int hp:300
    property bool createPeaFlag: false
    property bool canShot:true
    AnimatedImage{
        id:animatedImage
        source: "qrc:/images/plants/SnowPeaShooter.gif"
        visible:true
        anchors.fill: parent
    }

    function isAttacked(zombieAtk){
        if(zombieAtk)
            hp-=zombieAtk
    }

    function createSnowPeas() {
        var newSnowPea = Qt.createQmlObject('SnowPea{x: 123 * 0.75 * 0.65; y: 144 * 0.1 * 0.5}', snowPeaShooter);
    }

    Timer {
        id: createSnowPea
        interval: 3000; running: true; repeat: true
        onTriggered: {
            if(createPeaFlag === true) {
                createSnowPeas();
            }
        }
    }
}
