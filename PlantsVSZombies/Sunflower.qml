import QtQuick

Item {
    id:sunFlower

    property int hp:300
    property bool sunFlag: false
    //Rectangle{
        AnimatedImage{
            anchors.fill: parent
            id:animatedImage
            source: "qrc:/images/plants/SunFlower.gif"
            visible:true
        }
    //}
    Timer{
        interval: 3000 ; running: true
        repeat: true
        onTriggered: sunFlag=true;
    }

}
