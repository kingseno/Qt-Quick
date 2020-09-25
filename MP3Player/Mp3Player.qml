import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtQuick.Dialogs 1.2
import QtQml 2.14
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 1300
    height: 897
    maximumWidth: 1300
    maximumHeight: 897
    title: qsTr("Mp3 Player")
//    flags: Qt.Window | Qt.FramelessWindowHint // hide title ApplicationWindow


    property bool statusPlay: false
    property bool isnewList: true
    property var tempIndex: mp3.list.currentIndex
    property var current_Index: mp3.list.currentIndex
    property string albumArtist: "Unknow Album"
    property string author: "Unknow Author"
    property string titleMp3: "Unknow Title"
    property string yearComposed: "Unknow Year"

    Image{
        id: background
        source: "qrc:/Pictures/background-powerpoint-cong-nghe-17.jpg"
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        OpacityMask {
            source: mask
            maskSource: background
        }

        LinearGradient {
            id: mask
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.8; color: "transparent"}
                GradientStop { position: 1; color: "white";  }
            }
        }
    }

    MouseArea {
        id: iMouseArea
        property int prevX: 0
        property int prevY: 0
        anchors.fill: parent
        onClicked: control.visible = false
        onPressed: { prevX = mouse.x; prevY = mouse.y }
        onPositionChanged:{
            var deltaX = mouse.x - prevX;
            root.x += deltaX;
            prevX = mouse.x - deltaX;

            var deltaY = mouse.y - prevY
            root.y += deltaY;
            prevY = mouse.y - deltaY;
        }
    }

    onClosing: {
         var musicName = getNameFromPath(music.source);
         config.saveConfig(music.source, musicName, mp3.list.currentIndex, music.duration, music.position, music.volume);
    }

    Component.onCompleted: {
        config.loadHistoryConfig();
        var volume = config.currentVolume;
        var position = config.currentPossition;
        for(var i = 0; i < mp3.list.count; i++)
            if (mp3.list.model.get(i).Mp3Name === config.currentName){
                mp3.list.currentIndex = config.currentIndex;
                root.current_Index = mp3.list.currentIndex;
        }
        music.play();
        music.pause();
        music.volume = volume;
        music.seek(position);
    }

    ListMusic {
        id: mp3
    }

    DeleteDialog{
        id: deleteDialog
    }

    Timer {
            id: timer
            function delay(delayTime, callBackFunction) {
                interval = delayTime;
                repeat = false;
                triggered.connect(callBackFunction);
                triggered.connect(function release () {
                    triggered.disconnect(callBackFunction);
                    triggered.disconnect(release);
                });
                start();
            }
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.topMargin: 20
        anchors.rightMargin: 20

        Text{
            id: labelMp3
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 20
            font.bold: true
            font.pointSize: 16
            color: 'white'
            text: 'Chac Ai Do Se Ve - Son Tung MTP'
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: 300
            implicitWidth: 300
            SwipeView{
                id: swipeView
                anchors.fill: parent
                currentIndex: 0
                Item {
                    id: page1
                    Image {
                          id: image
                          sourceSize.width: 300
                          sourceSize.height: 300
                          anchors.centerIn: parent
                          source: "qrc:/Pictures/windows-media-player-8.png"
                          fillMode: Image.PreserveAspectFit
                    }
                }
                Item{
                    InfomationMp3{
                        id: infomation
                    }
                }
                Item{
                    Others{
                        id: other
                    }
                }
            }
            PageIndicator{
                count: swipeView.count
                currentIndex: swipeView.currentIndex
                anchors.bottom: swipeView.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

        }

        RowLayout {
            id: rowLayout
            Layout.fillWidth: true
            spacing: 10

            Text {
                id: element2
                color: 'white'
                text: msToTime(music.position)
                font.pixelSize: 12
                padding: 10
            }

            Slider{
                   id: progressBar
                   Layout.fillWidth: true
                   value: 0
                   padding: 2
                   background: Rectangle {
                       x: progressBar.leftPadding
                       y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
                       implicitWidth: 440
                       implicitHeight: 4
                       width: progressBar.availableWidth
                       height: implicitHeight
                       radius: 2
                       color: "gray"

                       Rectangle {
                           id: valueProgress
                           width: progressBar.visualPosition * parent.width
                           height: parent.height
                           color: "orange"
                           radius: 2
                       }
                   }

                   handle: Rectangle {
                       x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
                       y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
                       implicitWidth: 12
                       implicitHeight: 12
                       radius: 6
                       color: progressBar.pressed ? "#f0f0f0" : "#f6f6f6"
                       border.color: "#bdbebf"
                  }
                   Binding{
                       target: progressBar
                       property: "value"
                       restoreMode: Binding.RestoreNone
                       value: music.position/music.duration
                       when: !progressBar.pressed
                   }
                   onPressedChanged: {
                       music.seek(value*music.duration)
                   }
            }

            Text {
                id: element3
                color: 'white'
                text: msToTime(music.duration)
                font.pixelSize: 12
                padding: 10
            }
        }

        RowLayout {
            id: rowLayout1
            Layout.alignment: Qt.AlignCenter
            spacing: 30

            Image {
                id: open
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/Pictures/folder-open-solid.svg"
                fillMode: Image.PreserveAspectFit
                state: "none"
                MouseArea{
                    id: mouseArea7
                    anchors.fill: parent
                    onClicked: openProcess()
                    onPressed: open.state = "pressed"
                    onReleased: open.state = "none"

                }
                states: State {
                    name: "pressed"
                    when: mouseArea7.pressed
                    PropertyChanges { target: open; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }

            Image {
                id: stop
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/Pictures/stop-solid.svg"
                fillMode: Image.PreserveAspectFit
                state: "none"
                smooth: true
                BorderImage {
                    width: 50; height: 50
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                }
                MouseArea{
                    id: mouseArea8
                    anchors.fill: parent
                    onClicked: stopProcess()
                    onPressed: stop.state = "pressed"
                    onReleased: stop.state = "none"

                }
                states: State {
                    name: "pressed"
                    when: mouseArea8.pressed
                    PropertyChanges { target: stop; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }

            Image {
                id: previous
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/Pictures/step-backward-solid.svg"
                fillMode: Image.PreserveAspectFit
                state: "none"
                MouseArea{
                    id: mouseArea5
                    anchors.fill: parent
                    onClicked: previousProcess()
                    onPressed: previous.state = "pressed"
                    onReleased: previous.state = "none"

                }
                states: State {
                    name: "pressed"
                    when: mouseArea5.pressed
                    PropertyChanges { target: previous; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }

            Image {
                id: play
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/Pictures/play-circle-regular.svg"
                fillMode: Image.PreserveAspectFit
                state: "none"
                MouseArea{
                    id: mouseArea2
                    anchors.fill: parent
                    onClicked: togglePlay()
                    onPressed: play.state = "pressed"
                    onReleased: play.state = "none"

                }
                states: State {
                    name: "pressed"
                    when: mouseArea2.pressed
                    PropertyChanges { target: play; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }

            Image {
                id: next
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/Pictures/step-forward-solid.svg"
                fillMode: Image.PreserveAspectFit
                state: "none"
                MouseArea{
                    id: mouseArea3
                    anchors.fill: parent
                    onClicked: nextProcess()
                    onPressed: next.state = "pressed"
                    onReleased: next.state = "none"

                }
                states: State {
                    name: "pressed"
                    when: mouseArea3.pressed
                    PropertyChanges { target: next; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }

            Image {
                id: volume
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/Pictures/volume-up-solid.svg"
                fillMode: Image.PreserveAspectFit
                state: "none"
                MouseArea{
                    id: mouseArea4
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked:{
                        control.visible =true
                    }

                    onPressed: {
                        control.visible =true
                        volume.state = "pressed"
                    }
                    onReleased: {
                        control.visible = false
                        volume.state = "none"
                    }

                }
                states: State {
                    name: "pressed"
                    when: mouseArea4.pressed
                    PropertyChanges { target: volume; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }
            Image {
                id: list
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                source: "qrc:/Pictures/list-solid.svg"
                fillMode: Image.PreserveAspectFit
                state: "none"
                MouseArea{
                    id: mouseArea6
                    anchors.fill: parent
                    onClicked: showList()
                    onPressed: list.state = "pressed"
                    onReleased: list.state = "none"

                }
                states: State {
                    name: "pressed"
                    when: mouseArea6.pressed
                    PropertyChanges { target: list; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }
        }
    }

    Slider {
        id: control
        value: music.volume
        orientation: Qt.Vertical
        visible : false
        rotation: 180
        x : parent.width/2 + 120 + control.width/2
        y : parent.height - volume.height - 220

        background: Rectangle{
            x: control.leftPadding + control.availableWidth / 2 - width / 2
            y: control.topPadding
            implicitWidth: 4
            implicitHeight: 200
            width: implicitWidth
            height: control.availableHeight
            radius: 2
            color: "gray"

            Rectangle {
                width: parent.width
                height: control.visualPosition * parent.height
                color: "black"
                radius: 2
            }
        }

        handle: Rectangle {
            y: control.topPadding + control.visualPosition * (control.availableHeight - height)
            x: control.leftPadding + control.availableWidth / 2 - width / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: control.pressed ? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbebf"
        }
        onValueChanged: {
            music.volume = value;
        }
    }

    MediaPlayer{
        id: music
        source: config.currentDir
        volume: control.value
        // autoplay when music finish
        onStatusChanged: {
            if (status == MediaPlayer.EndOfMedia)
                nextProcess()
        }
        onPlaying:{
            if(statusPlay == true){
                if( typeof music.metaData.author !== "undefined"){
                    author = music.metaData.author;
                }
                if( typeof music.metaData.title !== "undefined"){
                    titleMp3 = music.metaData.title;
                    convertVNToNonAccent(titleMp3)
                    .then(function(title){
                         console.log(title);
                    });
                }
                if( typeof music.metaData.albumArtist !== "undefined"){
                    albumArtist = music.metaData.albumArtist;
                }
                if( typeof music.metaData.year !== "undefined"){
                    console.log("year: " + music.metaData.year)
                    yearComposed = music.metaData.year;
                }
                labelMp3.text = titleMp3 +" - " + author;
            }
        }
    }

    // open dialog to select music files
    FileDialog{
        id : openFile
        title: 'Select Files'
        folder: "folder:/D:/Thanh/Exercise/Qt/MP3Player/Musics"
        nameFilters: ["Music files (*.mp3)"]
        selectMultiple: true
        onAccepted:{

            // if open new list musics => delete all old configs
            if(isnewList){
                config.deleteConfig();
                music.source = fileUrls[0];
                music.play();
                music.pause();
                statusPlay = false;
                current_Index = 0;
            }
            // get information to create/append config and update list music
            for(var i in fileUrls)
            {
                var musicName = getNameFromPath(fileUrls[i]);
                config.createConfigHandler(fileUrls[i], musicName, i, 0, 0, control.value);
            }
            //load list music using function from DeleteDialog component.
            mp3.loadListMusic()
            if(!statusPlay)
                stopProcess();
            isnewList = true;
        }
    }

    SpectrumAnimation{
        id: spectrumAnimation
        y:  250

    }

    //Animation

    NumberAnimation {
        id: animation
        target: labelMp3
        property: "x"
        from: 0
        to: root.width
        loops: Animation.Infinite
        duration: 10000
    }
    NumberAnimation {
        id: animation2
        target: image
        property: "rotation"
        from: 0
        to: 360
        loops: Animation.Infinite
        duration: 10000
    }

    //Functions

    function convertVNToNonAccent(str){
        return new Promise(function(resolve, reject){
            str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
            str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
            str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
            str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
            str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
            str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
            str = str.replace(/đ/g, "d");
            str = str.replace(/\u0300|\u0301|\u0303|\u0309|\u0323/g, ""); // ` ' ~ ? .
            str = str.replace(/\u02C6|\u0306|\u031B/g, ""); // Â, Ê, Ă, Ơ, Ư
            resolve(str);
        });
    }

    function getNameFromPath(path){
        var m_path = path.toString();
        m_path = m_path.replace(/^.*[\\\/]/, '');
        m_path = m_path.substr(0, m_path.lastIndexOf('.'));
        return m_path
    }

    function msToTime(duration) {
        var seconds = parseInt((duration/1000)%60);
        var minutes = parseInt((duration/(1000*60))%60);

        minutes = (minutes < 10) ? "0" + minutes : minutes;
        seconds = (seconds < 10) ? "0" + seconds : seconds;

        return minutes + ":" + seconds;
    }

    function stopProcess(){
        if(music.hasAudio)
        {
            console.log(labelMp3.text + " is stopped");
        }
        else{
            labelMp3.text = ""
        }
        progressBar.value = 0
        statusPlay = false
        play.source = "qrc:/Pictures/play-circle-solid.svg"
        music.stop()
        image.rotation = 0
//        animation2.stop()
        animation.restart()
        animation.stop()
        spectrumAnimation.visible = false;
    }

    function togglePlay(){
        if(statusPlay === true)
        {
            pauseProcess()
        }else
        {
            playProcess()
        }
    }
    function playProcess(){
        statusPlay = true
        music.play();
        play.source = "qrc:/Pictures/pause-circle-solid.svg"
        animation.restart();
//        animation2.restart();
        spectrumAnimation.visible = true;
    }

    function pauseProcess(){
        statusPlay = false
        music.pause()
        play.source = "qrc:/Pictures/play-circle-solid.svg"
        animation.stop()
//        animation2.stop()
        spectrumAnimation.visible = false;
    }

    function nextProcess(){
        if(mp3.list.currentIndex == (mp3.list.count - 1)){
             mp3.list.currentIndex = 0;
        }else{
           mp3.list.currentIndex += 1
        }
        root.current_Index = mp3.list.currentIndex
        config.loadConfig(mp3.list.model.get(mp3.list.currentIndex).Mp3Name);
        music.source = config.currentDir;
        music.stop();
        playProcess();
    }

    function previousProcess(){
        if(mp3.list.currentIndex == 0){
             mp3.list.currentIndex = (mp3.list.count - 1);
        }else{
           mp3.list.currentIndex -= 1
        }
        root.current_Index = mp3.list.currentIndex
        config.loadConfig(mp3.list.model.get(mp3.list.currentIndex).Mp3Name);
        music.source = config.currentDir;
        music.stop();
        playProcess();
    }

    function showList(){
        mp3.visible = true;
        mp3.open()
    }

    function openProcess(){
        openFile.open()
    }
}

/*##^##
Designer {
    D{i:4;invisible:true}D{i:5;invisible:true}
}
##^##*/
