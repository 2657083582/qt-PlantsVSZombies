import QtQuick

Rectangle {
    id:card

    required property string name
    required property url path
    required property string cost

    //required property int index
    //default property bool flag: false
    color:"transparent"
    width:90
    height: 120

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/images/interface/Card.png"

        Rectangle{
            width: parent.width*0.6
            height: parent.height*0.6
            anchors.top:parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            color:"transparent"
            Image{
                id:img

                anchors.fill:parent
                source:card.path
                fillMode: Image.PreserveAspectFit
            }
        }

        Text{
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 5

            text:card.cost
            font.pixelSize: 20
        }
    }
    states:[
        State {
            name:"to be selected"
            PropertyChanges {
                target: card
                color:"transparent"
            }
        },
        State {
            name:"selected"
            PropertyChanges {
                target: card
                color:Qt.rgba(0,0,0,0.5)
            }
        }
    ]
    state:"to be selected"
    TapHandler{
        onTapped: {
            card.state=card.state==="to be selected"?"selected":"to be selected"

        }
    }
}
