//铁桶僵尸
import QtQuick

Item {
    id: root
    property int row: Math.floor(Math.random()*5)
    x: parent.width
    y: row*144+135.2
    width: 123
    height: 144
    state: "fine"

    signal leftest();
    signal mower();
    signal die();
    property alias image: image
    property alias advance: advance

    property int hp: 200 + 1100
    property int atk: 100
    property int speed: 123 / 4.7
    property bool atking: false

    // be atked
    function attacked(atk) {
        hp -= atk;
    }

    // change state by argument
    function stateChange(argument) {
        root.state = argument
    }

    // zombie arrived left
    // error: connot emit single signal
    onXChanged: {
        if(root.x < 100 && root.x > 99) {
            root.mower();
            console.log("mover");
        }
        if(root.x < 2 && root.x > 1) {
            root.leftest();
            console.log("leftest");
        }
    }

    // change state by hp
    onHpChanged: {
        if(! hp > 0) {
            stateChange("head");
            stateInterval.running = true;
        }
    }

    // atking state
    onAtkingChanged: {
        if(atking === true) {
            stateChange("attack");
        }
        else if(akting === false && hp > 0) {
            stateChange("fine");
        }
    }

    // sequently set different state
    Timer {
        id: stateInterval
        interval: 500; running: false; repeat: true
        onTriggered: {
            if(root.state === "head") {
                stateChange("lostHead");
            }else if(root.state === "lostHead") {
                //stateChange("die");
                stateInterval.repeat = false;
                root.visible=false
            }
        }
    }

    // advance
    NumberAnimation on x {
        id: advance
        to: 0
        duration: 1260 / speed * 1000
        running: hp > 0 && atking === false
    }

    // zombie interface
        AnimatedImage {
            id: image
            anchors.fill: parent
        }

        // some states
        states: [
            State {
                name: "fine"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/BucketheadZombie/BucketheadZombie.gif"
                }
            },
            State {
                name: "attack"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/BucketheadZombie/BucketheadZombieAttack.gif"
                }
            },
            State {
                name: "die"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/NormalZombie/NormalZombieDie.gif"
                }
            },
            State {
                name: "head"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/NormalZombie/NormalZombieHead.gif"
                }
            },
            State {
                name: "lostHead"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/NormalZombie/NormalZombieLostHead.gif"
                }
            },
            State {
                name: "lostHeadAttack"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/NormalZombie/NormalZombieLostHeadAttack.gif"
                }
            }
        ]
}
