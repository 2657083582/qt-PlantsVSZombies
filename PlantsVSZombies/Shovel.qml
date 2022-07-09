//铲子
import QtQuick

Item {
    property alias shovel: shovel
    property bool selected: false
    id:shovel
    width: 70*1.3
    height:72*1.3
    Image {
        anchors.fill: parent
        source: "qrc:/images/interface/ShovelBank.png"
        fillMode: Image.PreserveAspectFit
        Item{
            width: parent.width*0.8
            height: parent.height*0.8
            anchors.centerIn: parent
            Image{
                anchors.fill:parent
                source: "qrc:/images/interface/Shovel.png"
            }
        }
    }
    Rectangle{
        id:rec
        anchors.fill: parent
        color:"transparent"
    }

    TapHandler{
        onTapped: {
            shovel.selected=true
        }
    }
    onSelectedChanged: {
        if(shovel.selected==true)
            rec.color=Qt.rgba(128,128,128,0.5)
        else
            rec.color="transparent"
    }
}
