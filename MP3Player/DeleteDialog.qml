import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Dialog {
    id: deleteDialog
    width: 300
    height: 120

    header: Rectangle{
        width: parent.width
        height: 30
        color: 'gray'
        Text{
            color: 'white'
            id: header
            anchors.centerIn: parent
            font.pointSize: 10
            text: "Remove Item"
        }
    }

    RowLayout{
        spacing: 50
        Button{
            id: yesbutton
            text: "YES"
            implicitHeight: 50
            implicitWidth: 100
            x: Layout.left + 10
            onClicked: {
                if(root.current_Index > root.tempIndex)
                    root.current_Index -= 1;
                config.removeMusic(mp3.list.model.get(root.tempIndex).Mp3Name);
                mp3.removeMusic();
                mp3.loadListMusic();
                deleteDialog.close();
            }
        }
        Button{
            text: "NO"
            implicitHeight: 50
            implicitWidth: 100
            x: Layout.left + yesbutton.implicitWidth
            onClicked: deleteDialog.close();
        }
    }

    Component.onCompleted: deleteDialog.close();

}
