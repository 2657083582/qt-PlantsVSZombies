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
        function getSource(){
            //var name=arguments[0];
            //console.log(name);
            //console.log(shop.listModel.index(name))
            var index=Number(arguments[0].toString().slice(',')[0])

            //console.log("count"+shop.listModel.count)

            var filepath=shop.listModel.get(index).path.toString()
            var length=filepath.length
            var gifPath=filepath.substring(0,length-4)+".gif"
            console.log(filepath)
            return gifPath

        }

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



                    }

                    HoverHandler{
                        id: mouse
                        acceptedDevices: PointerDevice.Mouse
                        cursorShape: Qt.PointingHandCurso
                    }
                    TapHandler{
                        onTapped: {
                            if(shop.order!==-1){

                                animated.source=grid.getSource(shop.order)

                                animated.visible=true

                            }

                         }
                    }
                }

           }

       }
    }



}
