/* MainMenu.qml
// create the mainMenu
*/
import QtQuick
import QtQuick.Controls

Item {
    id: root
    anchors.fill: parent

    // sinal for mainMenu's game function
    signal start(); signal record();
    signal setting(); signal quit();

    // mainMenu's game function
    Rectangle {
        id: start
        width: parent.width / 25 * 3
        height: parent.height / 20
        radius: height
        color: "#579572"
        border.width: 5
        border.color: "#b2bbbe"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 10
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 5

        Image {
            anchors.fill: parent
            source: "qrc:/images/interface/Button.png"
            Text {
                color: "#fa7e23"
                anchors.centerIn: parent
                text: qsTr("Start")
            }
            TapHandler {
                onTapped: {
                    root.start()
                }
            }
        }


    }
    Rectangle {
        id: record
        width: parent.width / 25 * 3
        height: parent.height / 20
        radius: height
        color: "#579572"
        border.width: 5
        border.color: "#b2bbbe"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 10
        anchors.left: start.right
        anchors.leftMargin: parent.width / 25

        Image {
            anchors.fill: parent
            source: "qrc:/images/interface/Button.png"
            Text {
                color: "#fa7e23"
                anchors.centerIn: parent
                text: qsTr("Record")
            }
            TapHandler {
                onTapped: {
                    root.record()
                }
            }
        }
    }
    Rectangle {
        id: setting
        width: parent.width / 25 * 3
        height: parent.height / 20
        radius: height
        color: "#579572"
        border.width: 5
        border.color: "#b2bbbe"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 10
        anchors.left: record.right
        anchors.leftMargin: parent.width / 25

        Image {
            anchors.fill: parent
            source: "qrc:/images/interface/Button.png"
            Text {
                color: "#fa7e23"
                anchors.centerIn: parent
                text: qsTr("Setting")
            }
            TapHandler {
                onTapped: {
                    root.setting()
                }
            }
        }
    }
    Rectangle {
        id: quit
        width: parent.width / 25 * 3
        height: parent.height / 20
        radius: height
        color: "#579572"
        border.width: 5
        border.color: "#b2bbbe"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 10
        anchors.left: setting.right
        anchors.leftMargin: parent.width / 25

        Image {
            anchors.fill: parent
            source: "qrc:/images/interface/Button.png"
            Text {
                color: "#fa7e23"
                anchors.centerIn: parent
                text: qsTr("Quit")
            }
            TapHandler {
                onTapped: {
                    root.quit()
                }
            }
        }
    }
}
