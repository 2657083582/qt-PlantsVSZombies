//撑杆僵尸
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

    property int hp: 200 + 230
    property int atk: 100
    property int speed: 123 / 2.5
    property bool atking: false
    property bool pole: true

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

    // polevaulting
    onPoleChanged: {
        stateChange("jump");
        root.speed = 123 / 4.5
    }

    // sequently set the jump state
    Timer {
        id: stateInterval
        interval: 500; running: false; repeat: true
        onTriggered: {
            if(root.state === "jump") {
                stateChange("jump");
            }else if(root.state === "jump2") {
                stateChange("jump2");
            }else if(root.state === "jump2") {
                stateChange("walk");
            }else if(root.state === "head") {
                stateChange("lostHead");
            }else if(root.state === "lostHead") {
                //stateChange("die");
                stateInterval.repeat = false;
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
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombie.gif"
                }
            },
            State {
                name: "attack"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieAttack.gif"
                }
            },
            State {
                name: "die"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieDie.gif"
                }
            },
            State {
                name: "head"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieHead.gif"
                }
            },
            State {
                name: "jump"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieJump.gif"
                }
            },
            State {
                name: "jump2"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieJump2.gif"
                }
            },
            State {
                name: "lostHead"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieLostHead.gif"
                }
            },
            State {
                name: "lostHeadAttack"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieLostHeadAttack.gif"
                }
            },
            State {
                name: "lostHeadWalk"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieLostHeadWalk.gif"
                }
            },
            State {
                name: "walk"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/PoleVaultingZombie/PoleVaultingZombieWalk.gif"
                }
            }
        ]
}
