//寒冰豌豆
import QtQuick

Item{
    id: snowPea
    width:20
    height:20
    property bool slow: true
    property double slowValue: 0.7
    property int damage: 20
    Image{
        id:peaImage

        property int speed: 123 / 0.5
        source: "qrc:/images/plants/SnowPea.gif"


    }
    NumberAnimation on x {
        id: advance
        to: 1200
        duration: 1260 / peaImage.speed * 1000
        running: true
    }
}
