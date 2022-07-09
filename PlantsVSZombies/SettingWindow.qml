//设置界面
import QtQuick

Item {
    id: root

    // signal for back mainWindow
    signal back()

    anchors.fill: parent
    visible: false

    Rectangle {
        id: back
        width: parent.width / 25 * 3
        height: parent.height / 20
        radius: height
        color: "#579572"
        border.width: 5
        border.color: "#b2bbbe"
        anchors.top: parent.top
        anchors.left: parent.left

        Image {
            anchors.fill: parent
            source: "qrc:/images/interface/Button.png"
            Text {
                color: "#fa7e23"
                anchors.centerIn: parent
                text: qsTr("Back")
            }
            TapHandler {
                onTapped: {
                    root.back()
                }
            }
        }


    }
}
