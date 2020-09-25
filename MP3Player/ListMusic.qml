import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.StateMachine 1.0 as DSM
import QtGraphicalEffects 1.0

Dialog{
    property alias list: list

    id: dialog1
    width: 1300
    height: 897
    visible: false
    Image{
        source: "qrc:/Pictures/albumcover.png"
        sourceSize.width: parent.width
        sourceSize.height: parent.height
    }

    ListModel {
        id: model
    }
    header: Rectangle{
        id: label
        width: parent.width
        height: 40

        gradient: Gradient {
            GradientStop {
                position: 0.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14148c"; to: "#0E1533"; duration: 5000 }
                    ColorAnimation { from: "#0E1533"; to: "#14148c"; duration: 5000 }
                }
            }
            GradientStop {
                position: 1.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14aaff"; to: "#437284"; duration: 5000 }
                    ColorAnimation { from: "#437284"; to: "#14aaff"; duration: 5000 }
                }
            }
        }

        Text{
            anchors.centerIn: parent
            font.pointSize: 20
            padding: 20
            color: "white"
            text: "List Music"
        }
    }

    Component {
        id: delegate
        Row{
            id: rect1
            spacing: 5
            property string colorRect1 : rect1.ListView.isCurrentItem ? "orange" : "white";
            property bool is_show: rect1.ListView.isCurrentItem ? true : false
            Rectangle {
                id: rec
                color : "darkgray"
                implicitWidth: dialog1.width - 300
                implicitHeight: 40
                Image{
                    id: list_element
                    source: "qrc:/Pictures/element_list.png"
                    anchors.fill: parent
                }

                Text {
                    id: music_name
                    text:  Mp3Name;
                    color: colorRect1
                    font.pixelSize: 16
                    anchors.centerIn: parent
//                    SequentialAnimation on color{
//                        running: is_show && root.statusPlay
//                        loops: Animation.Infinite
//                        ColorAnimation { from: "orange"; to: "darkorange"; duration: typeof (music.metaData.audioBitRate) !== "undefined" ? music.metaData.audioBitRate / 1000 : 200   }
//                        ColorAnimation { from: "blue"; to: "darkblue"; duration: typeof (music.metaData.audioBitRate) !== "undefined" ? music.metaData.audioBitRate / 1000 : 200   }
//                        ColorAnimation { from: "green"; to: "darkgreen"; duration: typeof (music.metaData.audioBitRate) !== "undefined" ? music.metaData.audioBitRate / 1000 : 200   }
//                        ColorAnimation { from: "yellow"; to: "lightyellow"; duration: typeof (music.metaData.audioBitRate) !== "undefined" ? music.metaData.audioBitRate / 1000 : 200   }
//                    }
                }

                MouseArea{
                    id: mouseList
                    x: 0; y: 0
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:
                    {
                        list_element.opacity = 0.5
                    }
                    onExited:
                    {
                        list_element.opacity = 1
                    }
                    onClicked: {
                            // load config
                            list.currentIndex = index
                            root.current_Index = list.currentIndex;
                            var musicName = list.model.get(list.currentIndex).Mp3Name;
                            config.loadConfig(musicName)
                            music.source = config.currentDir;
                            labelMp3.text = config.currentName;
                            root.playProcess();
                            dialog1.visible = false;
                            dialog1.close();
                    }
                }
            }
            Item{
                id: parentPulse
                implicitHeight: 40
                implicitWidth: 100
                visible: is_show && root.statusPlay
//                rotation: 180
                property int preVal;
                property int curVal;
                RowLayout{
                    spacing : 2
                    Repeater{
                        model: 20
                        Rectangle{
                            id: pulse1
                            Layout.preferredHeight: Math.random()*20 +20
                            Layout.preferredWidth: 100/20 -2
                            color: 'orange'

                            ColorAnimation {
                                loops: Animation.Infinite
                                running: true
                                target: pulse1
                                properties: "color"
                                from: "orange"
                                to: "darkorange"
                                duration: 1000
                            }

                            NumberAnimation{
                                id: animationId
                                target: pulse1
                                property: "Layout.preferredHeight"
                                from: parentPulse.preVal
                                to: parentPulse.curVal
                                easing.type: Easing.InOutQuad
                            duration: typeof (music.metaData.audioBitRate) !== "undefined" ? music.metaData.audioBitRate / 1000 : 200
                            }

                            Timer{
                                running: true
                                repeat: true
                                interval: 100
                                onTriggered:  {
                                    parentPulse.preVal = parentPulse.curVal
                                    parentPulse.curVal = Math.random()*30 + 10
                                    animationId.start()
                                }
                            }
                        }

                    }
                }
            }

            Image {
                id: recycleBin
                width: 40
                height: 40
                source: "qrc:/Pictures/free-recycle-bin-icon-vector-recycle-bin-icon-115534132079jvhnualpn.png"
                sourceSize.height: 40
                sourceSize.width: 40
                opacity: 0
                MouseArea{
                    id: mouseRecycle
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: recycleBin.opacity = 1
                    onExited: recycleBin.opacity = 0
                }
                ColorOverlay {
                    id: mouseRecycleColor
                    anchors.fill: parent
                    source: recycleBin
                    color: "white"
                    state: "none"
                    MouseArea{
                        id: mouseRecycle2
                        anchors.fill: parent
                        onClicked: {
                            root.tempIndex = index;
                            root.current_Index = mp3.list.currentIndex;
                            deleteDialog.open();
                        }
                        onPressed: mouseRecycleColor.state = "pressed"
                        onReleased: mouseRecycleColor.state = "none"

                    }
                    states: State {
                        name: "pressed"
                        when: mouseRecycle2.pressed
                        PropertyChanges { target: mouseRecycleColor; scale: 0.8 }
                    }
                    transitions: Transition {
                        NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                    }
                }
            }

        }

    }

    ListView {
        id: list
        model: model
        delegate: delegate
        anchors.fill: parent
        spacing: 10
        anchors.margins: 50
        onVisibleChanged: {
            function checkContains(model, Mp3Name) {
                for(var i = 0; i < model.count; i++)
                    if (model.get(i).Mp3Name === Mp3Name)
                        return true
                return false
            }
            function appendToListModel(item, index){
                if(!checkContains(model,item))
                    model.append({"Mp3Name":item})
            }
            config.listMusic.forEach(appendToListModel)
            if(typeof root.current_Index !== "undefined")
                currentIndex = root.current_Index
        }
   }
   Image{
       id: add_item
       y: list.height
       x: (dialog1.width)/2 - 40
       source: "qrc:/Pictures/plus-circle-solid.svg"
       sourceSize.height: 40
       sourceSize.width: 40
       state: "none"
       MouseArea{
           id: mouseArea
           anchors.fill: parent
           onClicked: {
               root.current_Index = mp3.list.currentIndex;
               root.isnewList = false;
               root.openProcess()
               loadListMusic()
           }
       }
   }
   ColorOverlay {
       anchors.fill: add_item
       source: add_item
       color: "white"
   }

   footer:Rectangle{
       id: rect
        width: parent.width
        height: 35
        gradient: Gradient {
            GradientStop {
                position: 0.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14148c"; to: "#0E1533"; duration: 5000 }
                    ColorAnimation { from: "#0E1533"; to: "#14148c"; duration: 5000 }
                }
            }
            GradientStop {
                position: 1.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14aaff"; to: "#437284"; duration: 5000 }
                    ColorAnimation { from: "#437284"; to: "#14aaff"; duration: 5000 }
                }
            }
        }
        Text{
            anchors.centerIn: parent
            text: 'Close'
            font.pointSize: 15
            padding: 10
            color: 'white'
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                dialog1.close()
                dialog1.visible = false;
            }
        }
    }
   function loadListMusic(){
       mp3.list.model.clear();
       mp3.visible = true;
       mp3.close();
   }

   function removeMusic(){
       list.model.remove(root.tempIndex,1);
   }
}
