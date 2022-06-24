import QtQuick

Item {
    id: root
    // to be confirmed
    x: parent.height / getRandomNum(min, max)
    y: parent.width / getRandomNum(min, max)

//    property alias hp: hp
//    property alias atk: atk
//    property alias speed: speed
    property alias image: image

    property int hp: 200 + 1100
    property int atk: 100
    property int speed: parent.width / 47

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
}
