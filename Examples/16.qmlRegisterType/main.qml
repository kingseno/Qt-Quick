import QtQuick 2.15
import QtQuick.Controls 2.12
import BackEnd 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // please refer: https://www.youtube.com/watch?v=t6jTQvwWNCE&list=PL54fdmMKYUJvahGcI0cZCwrNesEsNd42V&index=21
    // so hard to explain with comments in code
    NameInQml {
        id: instantiable
        name: "some name"
        objectId: 5647
        creationDate: new Date()
    }

    Column {
        anchors.centerIn: parent
        Text {
            text: "Take 4 (Registering C++ types with QML type system)"
        }
        Text {
            text: "ID: " + instantiable.objectId
        }
        Text {
            text: "Name: " + instantiable.name
        }
        Text {
            text: "Date: " + instantiable.creationDate
        }
    }
}
