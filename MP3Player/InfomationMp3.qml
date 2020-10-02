import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id : information
    anchors.fill: parent

    ListModel {
        id: leftGrid
        property bool completed: false
        property string albumArtist: root.albumArtist
        property string author: root.author
        property string titleMp3: root.titleMp3
        property string yearComposed: root.yearComposed

        Component.onCompleted: {
            append({name: "Album Artist: " + leftGrid.albumArtist});
            append({name: "Author: " + leftGrid.author});
            append({name: "Title Mp3: " + leftGrid.titleMp3});
            append({name: "Year: " + leftGrid.yearComposed});
            completed = true;
        }

        // 2. Update the list model:
        onAlbumArtistChanged: {
            if(completed) setProperty(0, "name", "Album Artist: " + leftGrid.albumArtist);
        }
        onAuthorChanged: {
            if(completed) setProperty(1, "name", "Author: " + leftGrid.author);
        }
        onTitleMp3Changed: {
            if(completed) setProperty(2, "name", "Title Mp3: " + leftGrid.titleMp3);
        }
        onYearComposedChanged: {
            if(completed) setProperty(3, "name", "Year: " + leftGrid.yearComposed);
        }

    }

    Component{
        id: delegateList
        Item{
            width: parent.width
            height: parent.height/5


            Text{
                anchors.centerIn: parent
                color: 'white'
                text: name
                font.pointSize: 25

            }
        }
    }

    ListView{
        anchors.fill: parent
        spacing: 20
        anchors.margins: 10
        anchors.leftMargin: 50
        anchors.rightMargin: 50
        model: leftGrid

        delegate: delegateList
    }
}
