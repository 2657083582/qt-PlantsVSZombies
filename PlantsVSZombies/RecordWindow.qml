/* RecordWindow.qml
// read record from database
// create recordWindow
*/
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

    // save data to create
    ListModel {
        id: listModel
        ListElement {
            name: ""
            record: ""
            index: 0
        }
        ListElement {
            name: ""
            record: ""
            index: 1
        }
        ListElement {
            name: ""
            record: ""
            index: 2
        }
        ListElement {
            name: ""
            record: ""
            index: 3
        }
        ListElement {
            name: ""
            record: ""
            index: 4
        }
        ListElement {
            name: ""
            record: ""
            index: 5
        }
    }

    // delegate record view
    Component {
        id: recordDelegate
        Rectangle {
            Text {
                focus: true
                text: qsTr("record " + index + "  " + name)
                TapHandler {
                    onTapped: console.log("tapped record " + (index + 1))
                }
            }
        }

    }

    // show records by gridview
    GridView {
        id: recordView
        width: parent.width
        height: parent.height - back.height
        anchors.top: back.bottom
        anchors.topMargin: back.height

        cellWidth: parent.width / 3
        cellHeight: parent.height / 3

        model: listModel
        delegate: recordDelegate
    }
}
