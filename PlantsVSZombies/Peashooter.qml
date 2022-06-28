import QtQuick

Item {
    //property  alias Peashooter: peaShooter
    id:peaShooter
    property int hp:300
    property bool createPeaFlag: false

    AnimatedImage{
        id:animatedImage
        source: "qrc:/images/plants/PeaShooter.gif"
        visible:true
        anchors.fill: parent
    }

    function isAttacked(zombieAtk){
        if(zombieAtk)
            hp-=zombieAtk
    }

    function createPeas() {
        var newPea = Qt.createQmlObject('Pea{x: 123 * 0.75 * 0.65; y: 144 * 0.1 * 0.5}', peaShooter);
    }

    Timer {
        id: createPea
        interval: 3000; running: true; repeat: true
        onTriggered: {
            if(createPeaFlag === true) {
                createPeas();
            }
        }
    }
}
