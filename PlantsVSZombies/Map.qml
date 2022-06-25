import QtQuick

Item {
    id:map
    property alias grid:grid
    property int phase:0

    onPhaseChanged: img.state=this.phase===0?"preparatory phase":"combat phase"
    Image{
        id:img
        anchors.fill: parent
        source:"qrc:/images/interface/Background.jpg"
        fillMode: Image.PreserveAspectFit
        sourceClipRect:Qt.rect(550,0,840,600)
        state:"preparatory phase"
        states:[
            State {
                name: "combat phase"
                when: map.phase=1
            },
            State{
                name:"preparatory phase"
                when:map.phase=0
            }
        ]
        transitions: [
            Transition {
                from: "preparatory phase"
                to: "combat phase"

                PropertyAnimation {
                    target: img
                    property: "sourceClipRect"
                    duration: 1500
                    to:Qt.rect(550,0,840,600)
                    easing.type: Easing.Linear
                }
            },
            Transition {
                from: "combat phase"
                to: "preparatory phase"
                PropertyAnimation {
                    target: img
                    property: "sourceClipRect"
                    duration: 1500
                    to:Qt.rect(180,0,840,600)
                    easing.type: Easing.Linear
                }
            }
        ]


    }

    Grid{
//        function getSource(){
//            var index=Number(arguments[0]/*.toString().slice(',')[0]*/)
//            console.log("para:"+index)
//            //console.log("count"+shop.listModel.count)
//            var filepath=shop.listModel.get(index).path
//            var length=filepath.length
//            var gifPath=filepath.substring(0,length-4)+".gif"
//            console.log(filepath)
//            return gifPath
//        }



        //z:-1
        id:grid
        focus: false
        visible: false
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
                border.color:"transparent"
                color:mouse.hovered?Qt.rgba(154,205,50,0.4):"transparent"
                focus: true
                Rectangle{
                    //种植植物
                    function createPlant(){
                        var index=Number(arguments[0]);
                        //获取植物名称
                        var plantName=shop.listModel.get(index).name;
                        //根据名称种植对应植物
                        if(plantName==="sunFlower")
                            Qt.createQmlObject('Sunflower{anchors.fill:parent}',plantcontainer);
                        if(plantName==="peaShooter")
                            Qt.createQmlObject('Peashooter{anchors.fill:parent}',plantcontainer);
                        if(plantName==="potatoMine")
                            Qt.createQmlObject('Potatomine{anchors.fill:parent}', plantcontainer);

                        //if(plantName==="Reapter") Qt.createQmlObject("Reapter.qml");
                        //if(plantName==="snowPea") Qt.createQmlObject("Snowpea.qml");

                        if(plantName==="cherryBomb")
                            Qt.createQmlObject('Cherrybomb{anchors.fill:parent}',plantcontainer);
                        if(plantName==="wallNut")
                            Qt.createQmlObject('Wallnut{anchors.fill:parent}',plantcontainer);

                    }

//                    function update(){

//                    }

                    id:plantcontainer
                    property bool hasPlant: false

                    width: parent.width*0.68
                    height: parent.height*0.68
                    anchors.centerIn: parent
                    color:"transparent"


//                    AnimatedImage{

//                        id:animated
//                        source: ""
//                        visible: false
//                        anchors.fill:parent
//                        playing: true
//                    }


                }
                HoverHandler{
                    id: mouse
                    acceptedDevices: PointerDevice.Mouse
                    cursorShape: Qt.PointingHandCurso
                }
                TapHandler{
                    onTapped: {
                        if(shop.order!==-1){//判断植物是否被选中
//                            animated.source=grid.getSource(shop.order)
//                            animated.visible=true
                              //判断当前区域是否有植物，若已经有植物则不可种植
                              if(!plantcontainer.hasPlant){
                                  plantcontainer.createPlant(shop.order)
                                  plantcontainer.hasPlant=true
                              }

                        }

                     }
                }

           }

       }
    }



}
