/*Qt6 program named planeVsZombie for study
//author:zhangjinli chenjiakai lishengwei
//*/
import QtQuick
import QtQuick.Controls
import QtMultimedia

ApplicationWindow {
    id: root

    width: 1260
    height: 900
    maximumWidth: width
    minimumWidth: width
    maximumHeight: height
    minimumHeight: height
    visible: true
    title: qsTr("Hello World")

    // almost play theme music
    // some error: qt.multimedia.player: Unable to set the pipeline to the paused state.
    MediaPlayer {
        id: music
        source: "qrc:/medias/Kitanai Sekai.mp3"
        audioOutput: AudioOutput{}
        loops: music.Infinite
    }

    // theme backgroundImage
    // have different opacity in different window
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/images/interface/background.png"
        // clip backgroudImage
        // make some error maybe
        sourceSize.width: 1260
        sourceSize.height: 900
        sourceClipRect: Qt.rect(0,-100, 1260, 900)
        opacity: 1.0
    }

    // mainMenu also mainWindow
    // to choose start/record/setting/quit and act it's function
    MainMenu {
        id: mainMenu

        Component.onCompleted: {music.play()}


        onStart: {
            loader.active=true
            music.stop()
            console.log("start")
        }
        onRecord: {
            console.log("record")
            mainMenu.visible = false
            recordWindow.visible = true
            backgroundImage.opacity = 0.5
        }
        onSetting: {
            console.log("setting")
            mainMenu.visible = false
            settingWindow.visible = true
            backgroundImage.opacity = 0.5
        }
        onQuit: {
            console.log("quit")
            root.close()
        }
    }

    // save the records for unfinished game
    // use it to continue unfinished game
    RecordWindow {
        id: recordWindow
        onBack: {
            recordWindow.visible = false
            mainMenu.visible = true
            backgroundImage.opacity = 1.0
        }
    }

    // set the audio...
    SettingWindow {
        id: settingWindow
        onBack: {
            settingWindow.visible = false
            mainMenu.visible = true
            backgroundImage.opacity = 1.0
        }
    }

    Loader{
        id:loader
        source: "GameWindow.qml"
        active: false
    }
}
