import QtQuick 2.15
import QtQuick.Controls 2.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        color: 'white'
        anchors.centerIn: parent
        // refer: https://svn.banvien.com.vn/svn/LearningDevelopment_Department/trunk/QT_Knowledge/qt5_cadaques.pdf
        // to understand shader
        ShaderEffect {
            id: genieEffect
            width: 200
            height: width
            visible: true
            anchors.centerIn: parent
            property variant source : Image { source: 'qrc:/image.jpg' }
            property real minimize: 0.0
            property real bend: 0.0
            property bool minimized: false
            property real side: 1.0
            property real redChannel: 0.3

            MouseArea {
                anchors.fill: parent
                onClicked: parent.minimized = !parent.minimized
            }

            ParallelAnimation {
                id: animMinimize
                running: genieEffect.minimized
                SequentialAnimation {
                    PauseAnimation { duration: 150 }
                    NumberAnimation {
                        target: genieEffect; property: 'minimize';
                        to: 1; duration: 350;
                        easing.type: Easing.InOutSine
                    }
                    PauseAnimation { duration: 500 }
                }
                SequentialAnimation {
                    NumberAnimation {
                        target: genieEffect; property: 'bend'
                        to: 1; duration: 350;
                        easing.type: Easing.InOutSine }
                    PauseAnimation { duration: 650 }
                }
            }

            ParallelAnimation {
                id: animNormalize
                running: !genieEffect.minimized
                SequentialAnimation {
                    NumberAnimation {
                        target: genieEffect; property: 'minimize';
                        to: 0; duration: 350;
                        easing.type: Easing.InOutSine
                    }
                    PauseAnimation { duration: 650 }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 150 }
                    NumberAnimation {
                        target: genieEffect; property: 'bend'
                        to: 0; duration: 350;
                        easing.type: Easing.InOutSine }
                    PauseAnimation { duration: 500 }
                }
            }

            vertexShader:
                "uniform highp mat4 qt_Matrix;
                    attribute highp vec4 qt_Vertex;
                    attribute highp vec2 qt_MultiTexCoord0;
                    uniform highp float height;
                    uniform highp float width;
                    uniform highp float minimize;
                    uniform highp float bend;
                    uniform highp float side;
                    varying highp vec2 qt_TexCoord0;
                    void main() {
                        qt_TexCoord0 = qt_MultiTexCoord0;
                        highp vec4 pos = qt_Vertex;
                        pos.y = mix(qt_Vertex.y, height, minimize);
                        highp float t = pos.y / height;
                        t = (3.0 - 2.0 * t) * t * t;
                        pos.x = mix(qt_Vertex.x, side * width, t * bend);
                        gl_Position = qt_Matrix * pos;
                    }"

            fragmentShader:
                "varying highp vec2 qt_TexCoord0;
                    uniform sampler2D source;
                    uniform lowp float qt_Opacity;
                    uniform lowp float redChannel;
                    void main() {
                        gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(redChannel, 1.0, 1.0, 1.0) * qt_Opacity;
                    }"
        }
    }
}
