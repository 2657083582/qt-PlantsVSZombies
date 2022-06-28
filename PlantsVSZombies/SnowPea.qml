import QtQuick

Image{
    id: snowPea
    property bool peaFlag: true
    property int speed: 123 / 0.5
    source: "qrc:/images/plants/SnowPea.gif"

    NumberAnimation on x {
        id: advance
        to: 1200
        duration: 1260 / speed * 1000
        running: true
    }
}
