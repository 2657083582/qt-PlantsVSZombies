//土豆雷
import QtQuick
//import QtQml.StateMachine as DSM

Item {
    id:potatoMine
    property string name: "potatoMine"
    property int hp:300
    property int damage:1800
    property int count:0
    property bool canShot:false
    property bool touched: false
    state:"PotatoMineNotReady"
    //Rectangle{
        AnimatedImage{
            id:animatedImage
            //source: "qrc:/images/plants/PotatoMineNotReady.gif"
            visible:true       
            anchors.fill: parent
            onStatusChanged: playing=(status!==animatedImage.Ready)
        }
    //}
    Timer{

        id:timer
        interval:6000
        repeat:false
        running:true
        triggeredOnStart: false
    }
    Timer{
        id:visualTimer
        interval: 500
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: animatedImage.visible=false
        onRunningChanged: visualTimer.start()
    }

    states:[
        State{
            name:"PotatoMineNotReady";
            PropertyChanges {
                target: animatedImage
                source:"qrc:/images/plants/PotatoMineNotReady.gif"
            }
        },
        State{
            name:"PotatoMine";when:!timer.running && !touched
            PropertyChanges {
                target: animatedImage
                source:"qrc:/images/plants/PotatoMine.gif"
            }
        },
        State{
            name:"PotatoBoom";when:touched
            PropertyChanges{
                target: animatedImage
                source:"qrc:/images/plants/PotatoMineMashed.gif"
            }
        },
        State{
            name:"PotatoText";//when:hp===0
            PropertyChanges {
                target: animatedImage
                source:"qrc:/images/plants/PotatoText.gif"
            }
        }

    ]
    transitions: [
            Transition{
                from:"PotatoBoom"
                to:"PotatoText"
                PropertyAnimation{
                    target: animatedImage
                    property: animatedImage.source
                    duration: 1000
                }
        }

    ]
    onTouchedChanged: {
        if(potatoMine.touched){
            potatoMine.state="PotatoBoom"
        }
    }

    onStateChanged: {
        if(potatoMine.state==="PotatoBoom"){
            potatoMine.hp=0
            visualTimer.running=true
        }
    }

    function isAttacked(zombieAtk){
        if(zombieAtk)
            hp-=zombieAtk
    }

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
