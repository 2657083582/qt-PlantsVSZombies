//地图，游戏的主要场景
import QtQuick
import QtQuick.Controls
import an.qt.PlantArr 1.0
import an.qt.ZombieArr 1.0
import an.qt.PeaArr 1.0
import an.qt.MowerArr 1.0

Item {
    property alias map: map
    property alias peaArr: peaArr
    id:map
    property alias grid:grid
    property alias totaltimer: totaltimer
    property int phase:0
    property bool row1HasMower: false
    property bool row2HasMower: false
    property bool row3HasMower: false
    property bool row4HasMower: false
    property bool row5HasMower: false

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

    Image{
        id:loseImage
        z:1
        source: "qrc:/images/interface/Fail.png"
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: 280
    }


    //安放植物的网格
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
                required property int peaFlag
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
                        var cost=Number(shop.listModel.get(index).cost)
                        var curSun=Number(shop.sun.text)
                        console.log("curSun:"+curSun,"Cost:"+cost)
                        if(curSun<cost){
                            return;
                        }else{
                            curSun-=cost
                            shop.sun.text=curSun.toString()
                        }

                        if(plantName==="sunFlower"){
                            newplant=
                            Qt.createQmlObject('Sunflower{anchors.fill:parent}',plantcontainer);

                        }
                        if(plantName==="peaShooter"){
                            newplant=
                            Qt.createQmlObject('Peashooter{anchors.fill:parent}',plantcontainer);
                            myGridModel.set(cell.row*9+cell.col,{"peaFlag":1});

                        }
                        if(plantName==="potatoMine"){
                            newplant=Qt.createQmlObject
                                    ('Potatomine{anchors.fill:parent}',plantcontainer);
                        }

                        if(plantName==="Reapter"){
                            newplant=Qt.createQmlObject
                                    ('RepeaShooter{anchors.fill:parent}',plantcontainer)
                            myGridModel.set(cell.row*9+cell.col,{"peaFlag":2});
                        }

                        if(plantName==="snowPea"){
                            newplant=Qt.createQmlObject
                                    ('SnowPeaShooter{anchors.fill:parent}',plantcontainer)
                            myGridModel.set(cell.row*9+cell.col,{"peaFlag":1});
                        }

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

                    function createPeas() {
                        var newPea = Qt.createQmlObject('Pea{x: 123 * 0.75 * 0.65; y: 144 * 0.1 * 0.5}', plantcontainer);
                        var tempRow=cell.row+1;
                        var tempCol=cell.col;
                        console.log("row:"+tempRow,"col:"+tempCol)
                        peaArr.appendPeaInPeaVec(tempRow,tempCol,newPea);
//                        if(!peaArr.peaVecIsEmpty(tempRow,tempCol)){
//                            console.log("peaVec"+tempRow,tempCol,"is not empty")
//                            console.log("length:",peaArr.lengthOfPeaList(tempRow,tempCol))
//                        }
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

                Timer {
                    id: createPea
                    interval: 3000; running: true; repeat: true
                    onTriggered: {
                        if(!zombieArr.zombieListIsEmpty(cell.row+1)) {
                            if(cell.peaFlag === 1)
                                plantcontainer.createPeas();
                        }
                    }
                }

           }
       }
        //存储grid中每个rectangle的行和列
        ListModel{
            id:myGridModel

            function createMolde(){
                var flag=0;
                for(var i=0;i<5;i++)
                    for(var j=0;j<9;j++)
                        myGridModel.append({"row":i,"col":j,"peaFlag":flag})
            }

            Component.onCompleted: {
                myGridModel.createMolde()
            }
        }
    }

    //植物容器，记录grid的每个各自中是否有植物，若有植物，arr[i][j]为1;否则为0
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
        Component.onCompleted: {
            peaArr.initPeaList()
        }
    }
    MowerArr {
        id: mowerArr
    }



    //选择植物
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

    //开始按钮
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
            if(totaltimer.running)
                totaltimer.start()
                singleZombieTimer.running=true
                singleSunTimer.running=true
        }

    }

    //用于产生僵尸的定时器
    Timer{
        function createZombie(){
            var newZombie;
            var random=Math.floor(Math.random()*3)
            if(random===0)
                newZombie=Qt.createQmlObject('BasicZombie{}',map);
            if(random===1)
                newZombie=Qt.createQmlObject('FlagZombie{}',map);
            if(random===2)
                newZombie=Qt.createQmlObject('ConeheadZombie{}',map);
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
    //生成除草机的定时器
    Timer {
        id: mowerTimer
        interval: 499
        repeat: false
        running: false
        triggeredOnStart: false
        onTriggered: {
            createMower()

        }
        function createMower() {
           for(var i = 0; i < 5; ++i) {
               var newMower = Qt.createQmlObject('Mower{}',map);
               newMower.y = 87 * 1.6 + 144 * i;
               mowerArr.appendMowerList(newMower);
               console.log("create mower " + i)
           }
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
            detectTimer.detectZombieCollideWithMower()
            detectTimer.detectMowerCollideWithZombie()
            detectTimer.detectZombieCollideWithPea()
            detectTimer.detectLose()
        }

        //碰撞检测（用于两个Item之间)
        function collide(item1,item2){
            if((item1.x+item1.width)>=item2.x){
                return true;
            }
            return false;
        }
        //碰撞检测（当其中一个item的坐标不方便直接获取，只能通过计算的到时用这个）
        function collidePos(x,item){
            if(x>=item.x){
                return true;
            }
            return false;
        }
        function collideWithOffset(item1,item2,offset){
            if((item1.x+offset+item1.width)>=item2.x){
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
                        if(tempPlant.name==="potatoMine" && tempPlant.state==="PotatoMine"){
                            tempPlant.touched=true
                            tempZombie.hp-=tempPlant.damage
                            zombieArr.removeZombieList(i,j);
                            --j;
                            plantArr.setItemVec(index,Cell,null)

                        }
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

        //检测僵尸与子弹碰撞
        function detectZombieCollideWithPea(){
            for(var i=1;i<=5;i++){
                for(var j=0;j<9;j++){
                    var lengthOfPeaArr=peaArr.lengthOfPeaList(i,j)
                    var lengthOfZombieArr=zombieArr.lengthOfZombieList(i)
                    var removePeaFlag=false;
                    var removeZombieFlag=false;
                    for(var k=0;k<lengthOfPeaArr;k++){
                        if(removePeaFlag){
                            --k;
                            removePeaFlag=false;
                        }
                        var tempPea=peaArr.getPeaInPeaVecAt(i,j,k);
                        for(var t=0;t<lengthOfZombieArr;t++){
                            if(removeZombieFlag){
                                --t;
                                removeZombieFlag=false;
                            }
                            var tempZombie=zombieArr.getZombie(i,t);
                            var offset=j*123+160;
                            if(collideWithOffset(tempPea,tempZombie,offset)){
                                console.log("pea collide with zombies")
                                tempZombie.hp-=tempPea.damage
                                if(tempPea.slow)
                                    tempZombie.speed*=tempPea.slowValue
                                peaArr.getPeaInPeaVecAt(i,j,k).destroy()
                                peaArr.removePeaInPeaVecAt(i,j,k);
                                --lengthOfPeaArr;
                                removePeaFlag=true
                            }
                            if(tempZombie.hp<=0){
                                //zombieArr.getZombie(i,j).hp=tempZombie.hp
                                zombieArr.removeZombieList(i,t)
                                --lengthOfZombieArr;
                                removeZombieFlag=true;
                            }
                        }
                    }
                }
            }
        }

        // 检测僵尸与除草机的碰撞
        function detectZombieCollideWithMower() {
            for(var i = 1; i <= 5; i++) {
                for(var j = 0; j < zombieArr.lengthOfZombieList(i); ++j){
                    var tempZombie = zombieArr.getZombie(i,j);
                    var mowerX = 100;
                    if(collidePos(mowerX, tempZombie)) {
                        var row = tempZombie.row;
                        mowerArr.getMower(row).move = true;
                        switch(row){
                        case 0:map.row1HasMower=false;
                            break;
                        case 1:map.row2HasMower=false;
                            break;
                        case 0:map.row1HasMower=false;
                            break;
                        case 1:map.row2HasMower=false;
                            break;
                        case 0:map.row1HasMower=false;
                            break;
                        }
                    }
                }
            }
        }

        // 检测除草机与僵尸的碰撞
        function detectMowerCollideWithZombie() {
            for(var i = 1; i <= 5; i++) {
                var tempMower = mowerArr.getMower(i - 1);
                for(var j = 0; j < zombieArr.lengthOfZombieList(i); ++j){
                    var tempZombie = zombieArr.getZombie(i,j);
                    if(collide(tempMower, tempZombie) && tempMower.visible === true) {
                        tempZombie.state = "head";
                        tempZombie.hp = 0;
                        zombieArr.getZombie(i, j).hp = tempZombie.hp;
                    }
                }
            }


        }

        //判断游戏结束（当僵尸到达场景的最左边时游戏结束）
        function detectLose(){
            for(var i=1;i<=5;++i)
                for(var j = 0; j < zombieArr.lengthOfZombieList(i); ++j){
                    var tempZombie=zombieArr.getZombie(i,j);
                    if(tempZombie.x===0){
                        loseImage.visible=true
                        map.gameOver()
                    }
                }
        }
    }

    //检测各个对象的状态并根据状态判断是否摧毁该对象
    Timer{
        id:destroyTimer
        interval: 400
        repeat: true
        running: false
        onRunningChanged: destroyTimer.start()
        onTriggered: {
            detectPlantsHpandSetZombieMove()
            detectZombiesHp()
        }
        function detectPlantsHpandSetZombieMove(){
            for(var i=0;i<5;++i)
                for(var j=0;j<9;++j){
                    var temp=plantArr.getItemVec(i,j);
                    if(temp!==null && temp.hp<=0){
                        myGridModel.set(i*9+j,{"peaFlag":0})
                        temp.destroy();
                        plantArr.setItemVec(i,j,null);
                        for(var k=0;k<zombieArr.lengthOfZombieList(i+1);++k){
                            zombieArr.getZombie(i+1,k).atking=false;
                        }
                    }
                }
        }
        function detectZombiesHp(){
            for(var i=1;i<=5;++i){
                for(var j=0;j<zombieArr.lengthOfZombieList(i);++j){
                    var temp=zombieArr.getZombie(i,j);
                    if(temp.hp<=0){
                        temp.destroy();
                        zombieArr.removeZombieList(i,j);
                    }
                }
            }
        }
    }

    function gameOver(){
        totaltimer.running=false;
        singleZombieTimer.running=false
        singleSunTimer.running=false
        detectTimer.running=false
        destroyTimer.running=false
    }
}
