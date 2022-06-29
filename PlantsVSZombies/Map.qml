import QtQuick
import QtQuick.Controls
import an.qt.PlantArr 1.0
import an.qt.ZombieArr 1.0
import an.qt.PeaArr 1.0

Item {
    property alias plantArr: plantArr
    property alias peaArr: peaArr
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

                        if(plantName==="Reapter"){
                            newplant=Qt.createQmlObject
                                    ('RepeaShooter{anchors.fill:parent}',plantcontainer)
                        }

                        if(plantName==="snowPea")
                            newplant=Qt.createQmlObject
                                    ('SnowPeaShooter{anchors.fill:parent}',plantcontainer)

                        if(plantName==="cherryBomb"){
                            newplant=Qt.createQmlObject
                                    ('Cherrybomb{anchors.fill:parent}',plantcontainer);
                        }
                        if(plantName==="wallNut"){
                            newplant=Qt.createQmlObject
                                    ('Wallnut{anchors.fill:parent}',plantcontainer);
                        }

                        plantArr.setItemVec(row,col,newplant);
//                        console.log(newplant.hp)
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
                              //if(!plantcontainer.hasPlant){
                            if(plantArr.getItemVec(row,col)===null){
                                  plantcontainer.createPlant(shop.order)
                                  plantcontainer.hasPlant=true
                                  shop.order=-1
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
        onItemVecChanged: {
            plantArr.updateTempArr()
            plantArr.showItemVec()
            plantArr.showTempArr()
        }
        onRow1Attack:{
            for(var i=0;i<9;++i){
                if((plantArr.getItemVec(0,i)!==null) && (plantArr.getItemVec(0,i).canShot))
                    plantArr.getItemVec(0,i).createPeaFlag=true;
                else
                    continue;
            }
        }
        onRow2Attack:{
            for(var i=0;i<9;++i){
                if((plantArr.getItemVec(1,i)!==null) && (plantArr.getItemVec(1,i).canShot))
                    plantArr.getItemVec(1,i).createPeaFlag=true;
                else
                    continue;
            }
        }
        onRow3Attack:{
            for(var i=0;i<9;++i){
                if((plantArr.getItemVec(2,i)!==null) && (plantArr.getItemVec(2,i).canShot))
                    plantArr.getItemVec(2,i).createPeaFlag=true;
                else
                    continue;
            }
        }
        onRow4Attack:{
            for(var i=0;i<9;++i){
                if((plantArr.getItemVec(3,i)!==null) && (plantArr.getItemVec(3,i).canShot))
                    plantArr.getItemVec(3,i).createPeaFlag=true;
                else
                    continue;
            }
        }
        onRow5Attack:{
            for(var i=0;i<9;++i){
                if((plantArr.getItemVec(4,i)!==null) && (plantArr.getItemVec(4,i).canShot))
                    plantArr.getItemVec(4,i).createPeaFlag=true;
                else
                    continue;
            }
        }

    }
    ZombieArr{
        id:zombieArr
        //onAppendZombie: {zombieArr.ZombieExist}
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
    PeaArr{
        id:peaArr
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
            detectTimer.running=true
            destroyTimer.running=true
        }


    }

    //游戏时长定时器
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

    //用于产生僵尸的定时器
    Timer{
        function createZombie(){
            var newZombie=Qt.createQmlObject('BasicZombie{}',map)
            zombieArr.appendZombieList(newZombie.row+1,newZombie)
            zombieArr.zombieExist()
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
    //用于生产阳光的定时器
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
    //用于碰撞检测的定时器
    Timer{
        id:detectTimer
        interval:500
        repeat: true
        running: false
        onRunningChanged: detectTimer.start()
        onTriggered: {
            zombieArr.zombieExist()
            detectTimer.detectZombieCollideWithPlant()
        }

        //碰撞检测（用于两个Item之间)
        function collide(item1,item2){
            if((item1.x+item1.width)>=item2.x){
                return true;
            }
            return false;
        }
        //碰撞检测（当其中一个item的坐标不能直接获取，只能计算的到时用这个）
        function collidePos(x,item){
            if(x>=item.x){
                return true;
            }
            return false;
        }

        //检测僵尸与植物是否碰撞
        function detectZombieCollideWithPlant(){
            for(var i=1;i<=5;i++){
                var index=i-1;
                var Cell=plantArr.getTempArr(index);
                if(Cell===-1)
                    continue;
                var tempPlant=plantArr.getItemVec(index,Cell);
                for(var j=0;j<zombieArr.lengthOfZombieList(i);++j){
                    var tempZombie=zombieArr.getZombie(i,j);
                    var plantX=Cell*123+160;
                    if(collidePos(plantX,tempZombie)){
                        tempZombie.atking=true;
                        if(tempPlant!==null)
                            tempPlant.hp-=tempZombie.atk
                        else
                            break;
                    }
                    if(tempPlant.hp<=0){
                        plantArr.getItemVec(index,Cell).hp=tempPlant.hp;
                    }

                }
            }
        }
    }

    Timer{
        id:destroyTimer
        interval: 400
        repeat: true
        running: false
        onRunningChanged: destroyTimer.start()
        onTriggered: {
            detectPlantsHp()
        }
        function detectPlantsHp(){
            for(var i=0;i<5;++i)
                for(var j=0;j<9;++j){
                    var temp=plantArr.getItemVec(i,j);
                    if(temp!==null && temp.hp<=0){
                        temp.destroy();
                        plantArr.setItemVec(i,j,null);
                        zombieArr.getZombie(i+1,0).atking=false;
                    }
                }
        }
    }

}
