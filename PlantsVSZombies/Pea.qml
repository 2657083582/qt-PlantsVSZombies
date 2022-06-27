import QtQuick

Image{
    id: pea
    source: {if(peaFlag) return "qrc:/images/Pea.gif"; else return ""}
    Timer{
            //自定义数组对象来保存动态创建的矩形
            property var rectObj: []
            //自定义bool类型来标记对象是创建还是销毁
            property bool creatOrdestroy: false
            //定时器运行时间属性单位毫秒
            interval: 1400
            //开始就触发定时器
            running: true
            //不断重复
            repeat: true
            //定时器触发时来执行脚本
            onTriggered: {
                if((pea.x+pea.width)>zombie.x){//判断位置
                  for(var i = 0; i < 3000; i++){
                    rectObj.pop().destroy();
                  }
               }
            }
        }
        function creatObj(){
            var obj = creat.createObject(window,{
                                         });
            return obj;
        }
        Component{
            id:creat
            Item{
                id:peashoot
                property bool peaFlag
                property int damage:20
                x: parent.width - 5
                y: parent.height-5
                visible: false
                NumberAnimation on x {
                    id: shoot
                    duration: 1400
                    from: parent.width - 5
                    to: 900;
                    onStarted: {pea.visible = true}
                    onStopped: {pea.visible = true; shoot.restart(); flag = true}
                }
//                function shootRestart(){
//                    pea.visible = false
//                }
          }
        }
    //击中效果source:/root/qt-PlantsVSZombies/planeVsZombie/images/PeaHit.gif
}
