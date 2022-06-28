import QtQuick

Item {
    id: root
    property int row: Math.floor(Math.random()*5)
    x: parent.width
    y: row*144+135.2
    width: 123
    height: 144
    state: "fine"

    signal left();
    signal mower();
    signal die();
    property alias image: image
    property alias imageState: image.state

    property int hp: 200
    property int atk: 100
    property int speed: 123 / 4.7
    property bool atking: false

    Component.onCompleted: console.log(x)

    // be atked
    function attacked(atk) {
        hp -= atk;
    }

    // change state by argument
    function stateChange(argument) {
        image.state = argument
    }

    // zombie arrived left
    onXChanged: {
        if(root.x < 100 && root.x > 50) {
            root.mower();
        } else if(root.x < 10) {
            root.left();
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
            if(imageState === "head") {
                stateChange("lostHead");
            }else if(imageState === "lostHead") {
                stateChange("die");
                stateInterval.repeat = false;
                root.die();
                image.visible = false;
            }
        }
    }

    // advance
    NumberAnimation on x {
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
