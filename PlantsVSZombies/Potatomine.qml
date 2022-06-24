import QtQuick
//import QtQml.StateMachine as DSM

Item {
    id:potatoMine
    property int hp:300
    property int damage:1800
    property int count:0
    property var state:[]
    Rectangle{
        AnimatedImage{
            id:animatedImage
            source: "qrc:/images/PotatoMineNotReady.gif"
            visible:true       
        }
    }
    Timer{
        id:timer
        interval:6000
        repeat:false
        running:true
    }
    states:[
        State{
            name:"PotatoMine";when:timer.triggered()
            PropertyChanges {
                target: animatedImage
                source:"qrc:/images/PotatoMine.gif"
            }
        },
        State{
            name:"PotatoBoom";//when:touched  碰撞检测
            PropertyChanges{
                target: animatedImage
                source:"qrc:/images/PotatoMineMashed.gif"
            }
        },
        State{
            name:"PotatoText";when:hp===0
            PropertyChanges {
                target: animatedImage
                source:"qrc:/images/PotatoText.gif"
            }
        }

    ]
    transitions: [
            Transition{
                from:"PotatoBoom"
                to:"PotatoText"
                NumberAnimation{
                    target: animatedImage
                    property: animatedImage.source
                    duration: 1000
                }
        }

    ]

//    DSM.StateMachine{
//        id:stateMachine
//        initialState: animatedImage
//        running:true
//        DSM.State{
//            id:state
//            DSM.TimeoutTransition{
//                targetState: finalState
//                timeout:4000
//            }
//        }
//        FinalState{
//            id:finalState

//        }
//    }

}
