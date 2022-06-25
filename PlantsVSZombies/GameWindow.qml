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
        //phase: 0

        SeedChooser{
            z:1
            id:chooser
            visible:true
            focus:true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 60
            anchors.topMargin: 160
        }

        Button{
            id:btn
            width: 200
            height: 40

            anchors.top:chooser.bottom
            anchors.horizontalCenter: chooser.horizontalCenter
            anchors.topMargin: 0
            text:"Start"
            font.pixelSize: 30
            onClicked: {
                map.phase=map.phase===0?1:0
            }


        }
        onPhaseChanged: {
            grid.visible=map.phase===0?true:false
            chooser.visible=map.phase===0?false:true
            btn.visible=map.phase===0?false:true
            grid.focus=map.phase===0?true:false

        }
    }

    Shop{
        id:shop
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 0
        anchors.leftMargin: 50
    }
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
    Shovel{
        anchors.top:menu.bottom
        anchors.left: shop.right
        anchors.topMargin: 2
        anchors.leftMargin: 20
    }
//    Mower{

//    }


    MediaPlayer{
        id:player
        source: "qrc:/medias/Faster.mp3"
        audioOutput: AudioOutput{}
        loops: MediaPlayer.Infinite
    }

    Component.onCompleted: player.play()

}
