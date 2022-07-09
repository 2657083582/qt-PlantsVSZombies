//商店
import QtQuick

Item {
    property alias shop: shop
    //property alias num: num
    property alias listModel: listModel
    property alias listView:listView
    property int num: 0
    property int order: -1


    id:shop
    width: 446*2.4
    height: 87*1.6
    property alias sun : sun
    Image{
        anchors.fill: parent
        fillMode: Image.Stretch
        source: "qrc:/images/interface/Shop.png"

        Text{
            id:sun
            text:"300"
            font.pixelSize: 30
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.bottomMargin:5
            anchors.leftMargin: 40
            color:"#FFFFFF"
            TapHandler{
                onTapped: console.log("tapped")
            }
        }

    }
    Rectangle{
        width: 446*2+10
        height: 87*1.4
        anchors.left: parent.left
        anchors.top:parent.top
        anchors.leftMargin: 160
        anchors.topMargin: 7
        color:"transparent"
        ListView{
            id:listView
            anchors.fill: parent
            orientation: ListView.Horizontal
            delegate: Card{
                id:card
                required property int test
                TapHandler{
                    onTapped: {
                        listModel.IndexIsValid

                        console.log("test:",card.test)
                        shop.order=card.test
                    }
                }
                Component.onCompleted: {
                }
            }

            model:listModel
        }
    }

    ListModel{
        id:listModel

    }


}
