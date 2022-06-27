import QtQuick

Item {
    id:sunFlower
    anchors.fill: parent
    property int hp:300
    property bool sunFlag: false
        AnimatedImage{
            anchors.fill: parent
            id:animatedImage
            source: "qrc:/images/plants/SunFlower.gif"
            visible:true
        }


}
