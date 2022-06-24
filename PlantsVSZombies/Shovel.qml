import QtQuick

Item {
    width: 70*1.3
    height:72*1.3
    Image {
        anchors.fill: parent
        source: "file:///root/study/qt/PVZ-master/images/ShovelBank.png"
        fillMode: Image.PreserveAspectFit
        Item{
            width: parent.width*0.8
            height: parent.height*0.8
            anchors.centerIn: parent
            Image{
                anchors.fill:parent
                source: "file:///root/study/qt/PVZ-master/images/Shovel.png"
            }
        }
    }
}