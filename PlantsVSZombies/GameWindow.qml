//author:lishengwei
//date:2022.6.23
//description:this is the game windowof this app.
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
    //背景图
    Map{anchors.fill: parent}
    //商店（卡槽）
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
                source:"./images/Button.png"
                fillMode: Image.PreserveAspectFit
        }
        anchors.rightMargin: 40


        onClicked:{
            console.log("clicked")
        }
    }
    //铲子
    Shovel{
        anchors.top:menu.bottom
        anchors.left: shop.right
        anchors.topMargin: 2
        anchors.leftMargin: 20
    }
    //小推车
    Mower{}

    //草坪的网格
    Grid{
        width:1100
        height:720
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.topMargin: 130
        anchors.leftMargin: 100
        anchors.fill: parent
        columns: 9
        rows:5

        Repeater{
            model:45
            Rectangle{
                width: 123
                height:144
                //border.color:mouse.hovered?"red":"black"
                border.color:"transparent"
                color:mouse.hovered?Qt.rgba(154,205,50,0.4):"transparent"
                focus: true
                Rectangle{
                    width: parent.width*0.8
                    height: parent.height*0.8
                    anchors.centerIn: parent
                    color:"transparent"

                    AnimatedImage{

                        id:animated
                        source: ""
                        visible: false
                        anchors.fill:parent
                        playing: true
                        mirror: true


                    }

                    HoverHandler{
                        id: mouse
                        acceptedDevices: PointerDevice.Mouse
                        cursorShape: Qt.PointingHandCurso
                    }
                    TapHandler{
                        onTapped: {
                            console.log(shop.order,animated.source,animated.x-window.x)
                            if(shop.order!==-1){

                                switch(shop.order){
                                case 0:{
                                    animated.source="./images/SunFlower.gif";
                                    shop.order=-1;
                                    console.log(animated.source)
                                    break;
                                }
                                case 1:{
                                     animated.source="./images/Peashooter.gif";
                                     shop.order=-1;
                                     break;
                                }
                                case 2:{
                                    animated.source="./images/PotatoMine.gif";
                                    shop.order=-1;
                                    break;
                                }
                                case 3:{
                                    animated.source="./images/Repeater.gif";
                                    shop.order=-1;
                                    break;
                                }
                                case 4:{
                                    animated.source="./images/SnowPea.gif";
                                    shop.order=-1;
                                    break;
                                }
                                case 5:{
                                    animated.source="./images/CherryBomb.gif";
                                    shop.order=-1;
                                    break;
                                }
                                case 6:{
                                    animated.source="./images/WallNut.gif";
                                    shop.order=-1;
                                    break;
                                }
                                default:break;
                            }
                            animated.visible=true

                        }

                    }
                }
            }

           }

       }
    }
    //背景音乐
    MediaPlayer{
        id:player
        source: "file:///root/study/qt/PVZ-master/Grazy Dave.mp3"
        audioOutput: AudioOutput{}
        loops: MediaPlayer.Infinite
    }

    Component.onCompleted: player.play()

}
