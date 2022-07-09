//游戏窗口界面
import QtQuick
import QtQuick.Controls
import QtMultimedia

ApplicationWindow {

    id:window
    width: 1260
    height: 900
    visible: true
    title: qsTr("Plants VS Zombies")
    maximumWidth: width
    maximumHeight: height
    minimumWidth: width
    minimumHeight: height

    Map{
        id:map
        anchors.fill: parent

    }
    //商店
    Shop{
        id:shop
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 0
        anchors.leftMargin: 50
    }
    //菜单按钮
    Button{
        id:menu
        width: 113*0.8
        height: 41*0.8
        anchors.left: shop.right
        anchors.top:parent.top
        anchors.topMargin: 5
        anchors.leftMargin: 20
        Text{
            anchors.centerIn:parent
            text:"Menu"
            color: "lightgreen"
            font.pixelSize: 20
            font.weight: Font.Bold
        }

        background:
            Image{

                anchors.fill:parent
                source:"qrc:/images/interface/Button.png"
                fillMode: Image.PreserveAspectFit
        }
        anchors.rightMargin: 40


        onClicked:{
            console.log("clicked")
        }
    }
    //铲子
    Shovel{
        id:shovel
        anchors.top:menu.bottom
        anchors.left: shop.right
        anchors.topMargin: 2
        anchors.leftMargin: 20
    }

    MediaPlayer{
        id:player
        source: "qrc:/medias/Faster.mp3"
        audioOutput: AudioOutput{}
        loops: MediaPlayer.Infinite
    }

    Component.onCompleted: player.play()

}
