import QtQuick

Item {
    id: root

    x: parent.width
    y: (Math.floor(Math.random()*5))*144+135.2
    state: "fine"

    signal die();
    property alias image: image
    property alias imageState: image.state

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
        image.state = argument
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
            if(imageState === "head") {
                stateChange("lostHead");
            }else if(imageState === "lostHead") {
                stateChange("die");
                stateInterval.repeat = false;
                root.die();
            }
        }
    }

    // advance
    NumberAnimation on x {
        target: root
        to: 0
        duration: 1260 / speed * 1000
        running: hp > 0 && atking === false
    }

    // zombie interface
        AnimatedImage {
            id: image
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
