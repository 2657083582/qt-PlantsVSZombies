import QtQuick

Item {


    Image{
        anchors.fill: parent
        source:"./images/Background.jpg"
        fillMode: Image.PreserveAspectFit
        sourceClipRect:Qt.rect(180,0,840,600)
    }
}
