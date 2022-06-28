import QtQuick
import QtQuick.Controls
import an.qt.PlantArr 1.0
import an.qt.ZombieArr 1.0

Item {
    property alias map: map
    id:map
    property alias grid:grid
    property alias totaltimer: totaltimer
    property int phase:0

    //onPhaseChanged:
    onPhaseChanged: {
        img.state=this.phase===0?"preparatory phase":"combat phase"
        grid.visible=map.phase===0?true:false
        chooser.visible=map.phase===0?false:true
        btn.visible=map.phase===0?false:true
        grid.focus=map.phase===0?true:false

    }
    Image{
        id:img
        anchors.fill: parent
        source:"qrc:/images/interface/Background.jpg"
        fillMode: Image.PreserveAspectFit
        sourceClipRect:Qt.rect(550,0,840,600)
        state:"preparatory phase"
        states:[
            State {
                name: "combat phase"
                when: map.phase=1
            },
            State{
                name:"preparatory phase"
                when:map.phase=0
            }
        ]
        transitions: [
            Transition {
                from: "preparatory phase"
                to: "combat phase"

                PropertyAnimation {
                    target: img
                    property: "sourceClipRect"
                    duration: 1500
                    to:Qt.rect(550,0,840,600)
                    easing.type: Easing.Linear
                }
            },
            Transition {
                from: "combat phase"
                to: "preparatory phase"
                PropertyAnimation {
                    target: img
                    property: "sourceClipRect"
                    duration: 1500
                    to:Qt.rect(180,0,840,600)
                    easing.type: Easing.Linear
                }
            }
        ]
    }

    Timer {
        id: mowerTimer
        interval: 1500
        repeat: false
        running: false
        triggeredOnStart: false
        onTriggered: {
            createMower()
        }
        function createMower() {
           var newMower = Qt.createQmlObject('MowerCreator{}',map)
        }
    }

    Grid{
        //z:-1
        id:grid
        focus: false
        visible: false
        width:1100
        height:720
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.topMargin: 130
        anchors.leftMargin: 100
        anchors.fill: parent
        columns: 9
        rows:5

        Repeater{
            model:myGridModel
            Rectangle{
                id:cell
                required property int row
                required property int col
                width: 123
                height:144
                //border.color:"transparent"
                //border.color: "black"
                color:mouse.hovered?Qt.rgba(154,205,50,0.4):"transparent"
                focus: true
                Rectangle{

                    //种植植物
                    function createPlant(){
                        var newplant;
                        var index=Number(arguments[0]);
                        //获取植物名称
                        var plantName=shop.listModel.get(index).name;
                        //根据名称种植对应植物
                        if(plantName==="sunFlower"){
                            newplant=
                            Qt.createQmlObject('Sunflower{anchors.fill:parent}',plantcontainer);


                        }
                        if(plantName==="peaShooter"){
                            newplant=
                            Qt.createQmlObject('Peashooter{anchors.fill:parent}',plantcontainer);

                        }
                        if(plantName==="potatoMine"){
                            newplant=Qt.createQmlObject
                                    ('Potatomine{anchors.fill:parent}',plantcontainer);
                        }

//                        if(plantName==="Reapter") Qt.createQmlObject("Reapter.qml");
//                        if(plantName==="snowPea") Qt.createQmlObject("Snowpea.qml");

                        if(plantName==="cherryBomb"){
                            newplant=Qt.createQmlObject
                                    ('Cherrybomb{anchors.fill:parent}',plantcontainer);
                        }
                        if(plantName==="wallNut"){
                            newplant=Qt.createQmlObject
                                    ('Wallnut{anchors.fill:parent}',plantcontainer);
                        }

                        plantArr.setItemVec(row,col,newplant);
                        console.log(newplant.hp)
                    }

                    id:plantcontainer
                    property bool hasPlant: false

                    width: parent.width*0.68
                    height: parent.height*0.68
                    anchors.centerIn: parent
                    color:"transparent"
                }
                HoverHandler{
                    id: mouse
                    acceptedDevices: PointerDevice.Mouse
                    cursorShape: Qt.PointingHandCurso
                }
                TapHandler{
                    id:tapHandler
                    onTapped: {
                        if(shop.order!==-1){//判断植物是否被选中
                              //判断当前区域是否有植物，若已经有植物则不可种植
                              if(!plantcontainer.hasPlant){
                                  plantcontainer.createPlant(shop.order)
                                  plantcontainer.hasPlant=true
                                  shop.order=-1
                                  //plantArr.setArr(row,col,1)
                              }
                              console.log("position:"+cell.row,cell.col)
                        }
                        if(shovel.selected){//当铲子被选中时，如果当前区域有植物则铲除
                            if(plantcontainer.hasPlant){
                                plantArr.getItemVec(row,col).destroy();
                                plantArr.setItemVec(row,col,null);
                                plantcontainer.hasPlant=false;
                                console.log("destroy item");
                            }
                            shovel.selected=false;
                        }
                     }
                }
           }
       }
        //存储grid中每个rectangle的行和列
        ListModel{
            id:myGridModel

            function createMolde(){
                for(var i=0;i<5;i++)
                    for(var j=0;j<9;j++)
                        myGridModel.append({"row":i,"col":j})
            }

            Component.onCompleted: {
                myGridModel.createMolde()
            }
        }
    }

    //记录grid的每个各自中是否有植物，有arr[i][j]为1,否则为0
    PlantArr{
        id:plantArr
        Component.onCompleted: {
            plantArr.initItemVec()
            plantArr.initTempArr()
        }
        onItemVecChanged: {plantArr.updateTempArr()
            plantArr.showItemVec()
            plantArr.showTempArr()
        }
        onRow1Attack:{
            console.log("row 1 attack")
        }
        onRow2Attack:{
            console.log("row 2 attack")
        }
        onRow3Attack:{
            console.log("row 3 attack")
        }
        onRow4Attack:{
            console.log("row 4 attack")
        }
        onRow5Attack:{
            console.log("row 5 attack")
        }

    }
    ZombieArr{
        id:zombieArr
        onAppendZombie: {zombieArr.ZombieExist}
        onRow1hasZombie:{
            plantArr.row1Attack()
            //console.log("row 1 has zombie!");
        }
        onRow2hasZombie:{
            plantArr.row2Attack()
            //console.log("row 2 has zombie!");
        }
        onRow3hasZombie:{
            plantArr.row3Attack()
            //console.log("row 3 has zombie!");
        }
        onRow4hasZombie:{
            plantArr.row4Attack()
            //console.log("row 4 has zombie!");
        }
        onRow5hasZombie:{
            plantArr.row5Attack()
            //console.log("row 5 has zombie!");
        }
    }


    SeedChooser{
        z:1
        id:chooser
        visible:true
        focus:true
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 60
        anchors.topMargin: 160
    }

    Button{
        id:btn
        width: 200
        height: 40

        anchors.top:chooser.bottom
        anchors.horizontalCenter: chooser.horizontalCenter
        anchors.topMargin: 0
        text:"Start"
        font.pixelSize: 30
        onClicked: {
            map.phase=map.phase===0?1:0
            totaltimer.running=true
            mowerTimer.running = true
        }


    }

    Timer{
        id:totaltimer
        interval: 12000
        repeat: false
        running:false

        onRunningChanged: {
            if(totaltimer.running===true)
                totaltimer.start()
                singleZombieTimer.running=true
                singleSunTimer.running=true
        }

    }

    Timer{
        function createZombie(){
            var newZombie=Qt.createQmlObject('BasicZombie{}',map)
            zombieArr.appendZombieList(newZombie.row+1,newZombie)
            zombieArr.zombieExist(newZombie.row+1)
            console.log("hp:"+zombieArr.getZombie(newZombie.row+1,0).hp)
        }
        id:singleZombieTimer
        interval: 5000
        repeat: true
        running: false
        onRunningChanged: singleZombieTimer.start()
        onTriggered: {
            singleZombieTimer.createZombie()
        }
    }
    Timer{
        function createSun(){
            var sun=Qt.createQmlObject('Sun{}',map)
        }
        id:singleSunTimer
        interval: 4000
        repeat: true
        running:false
        onRunningChanged: singleSunTimer.start()
        onTriggered:{
            singleSunTimer.createSun()
        }
    }


    //BasicZombie{}
}
