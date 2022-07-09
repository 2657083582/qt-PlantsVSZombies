//除草机
import QtQuick

Item {
    id: root
    width: 100
    height: 100
    x: 0

    property int speed: 123 / 4
    property bool move: false

    onXChanged: {
        if(x > 1270) {
            root.visible = false
        }
    }

    AnimatedImage {
        anchors.fill: parent
        source:"qrc:/images/interface/LawnMower.gif"
    }

    onMoveChanged: {
        if(move) {
            move.running = true
        }
    }

    Timer {
        id: move
        interval: 100; running: false; repeat: true
        onTriggered: {
            x += speed
        }
    }
}
