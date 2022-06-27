import QtQuick

Item {
    id: root
    // to be confirmed
    y: (Math.floor(Math.random()*5))*144+135.2
    x:1200
    property alias image: image

    property int hp: 200
    property int atk: 100
    property int speed: parent.width/47
    width: 123
    height: 144
    state: "fine"

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



    // zombie interface
    AnimatedImage {
        anchors.fill: parent
        id: image
        source:"qrc:/images/Zombies/NormalZombie/NormalZombie.gif"

    }
    NumberAnimation on x {
        to: 0
        duration: speed*1000
        running: true

        Component.onCompleted: {
            console.log(duration)
            console.log("moving")
        }
    }

        // some states
        states: [
            State {
                name: "fine"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/NormalZombie/NormalZombie.gif"
                }
            },
            State {
                name: "attack"
                PropertyChanges {
                    target: image
                    source: "qrc:/images/Zombies/NormalZombie/NormalZombieAttack.gif"
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
