import QtQuick

Item{
    id:pea
    Image{
        id:peaImage
        property bool peaFlag: true
        property int speed: 123 / 0.5
        source: "qrc:/images/plants/Pea.gif"

        NumberAnimation on x {
            id: advance
            to: 1200
            duration: 1260 / peaImage.speed * 1000
            running: true
        }
    }
}
