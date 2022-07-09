//豌豆射手
import QtQuick
//import an.qt.PeaArr 1.0

Item {
    //property  alias Peashooter: peaShooter
    id:peaShooter
    property int hp:300
    property bool createPeaFlag: false
    property bool canShot:true
    property string name: "peaShooter"

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

//    function createPeas() {
//        var newPea = Qt.createQmlObject('Pea{x: 123 * 0.75 * 0.65; y: 144 * 0.1 * 0.5}', );
//        var tempRow=peaShooter.parent.parent.row+1;
//        var tempCol=peaShooter.parent.parent.col;
//        map.peaArr.appendPeaInPeaVec(tempRow,tempCol,newPea);
////        console.log("row:"+tempIndex);
//    }

//    Timer {
//        id: createPea
//        interval: 3000; running: true; repeat: true
//        onTriggered: {
//            if(createPeaFlag === true) {
//                createPeas();
//            }
//        }
//    }
//    Timer{
//        id:destroyPea
//        interval: 2000;running:true;repeat: true
//        onTriggered: {
//            for(var i=1;i<=5;i++){
//                for(var j=0;j<9;j++){
//                    for(var k=0;k<map.peaArr.lengthOfPeaList(i,j);k++){
//                        var tempPea=map.peaArr.getPeaInPeaVecAt(i,j)
//                        if(tempPea.x>=1260)
//                            map.peaArr.getPeaInPeaVecAt(i,j).destroy()
//                    }
//                }
//            }
//        }
//    }

}
