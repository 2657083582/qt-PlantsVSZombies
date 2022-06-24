import QtQuick

Item {
    id: root
    // to be confirmed
    x: parent.height / getRandomNum(min, max)
    y: parent.width / getRandomNum(min, max)

//    property alias hp: hp
//    property alias atk: atk
//    property alias speed: speed
//    property alias pole: pole
    property alias image: image
    property alias imageState: image.state

    property int hp: 200 + 230
    property int atk: 100
    property int speed: parent.width / 25
    property bool pole: true

    // get random number to set x or y
    function getRandomNum(min, max) {
        var range = max - min;
        var rand = Max.random();
        return (min + Math.round(rand * range));
    }

    // change state by argument from "view"
    function stateChange(argument) {
        image.state = argument
    }

    onHpChanged: {
        if(! hp > 0) {
            image.state = die
        }
    }

    onPoleChanged: speed = parent.width / 45

    // sequently set the jump state
    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
            if(imageState === "jump") {
                imageState = "jump2"
            }else if(imageState === "jump2") {
                imageState = "walk"
            }
        }
    }

    // advance
    NumberAnimation on x {
        target: root
        to: 0
        duration: speed
        running: hp > 0
    }

    // zombie interface
    Rectangle {
        id: basicZombie

        AnimatedImage {
            id: image
            state: fine
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
}
