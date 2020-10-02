import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import QtQuick 2.5
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

Entity {
    id: root2

    Camera{
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 1820 / 1080
        nearPlane: 0.1
        farPlane: 1000.0
        position: Qt.vector3d(4.5, -50, 30)
        upVector: Qt.vector3d(0, 0, 0)
        viewCenter: Qt.vector3d(0, 0.0, -5.0)
    }

    Entity{
        id: entity
        property color preVal;
        property color curVal;
        components: [
            Mesh{
                source: "qrc:/meshes/music_note (1).obj"
            },
            PhongMaterial{
                id: phongMaterial
                diffuse: "gold"
                ambient: "lightyellow"
            }
            ,
            Transform{
                id: transform
                scale: 1

                NumberAnimation on scale{
                    running: root.statusPlay
                    loops: Animation.Infinite
                    from: 0.5; to: 1
                    duration: 800
                }
                ColorAnimation{
                    id: colorAnimation
                    target: phongMaterial
                    properties: "diffuse"
                    from: entity.preVal
                    to: entity.curVal
                    duration: 500
                }
                Timer{
                    running: root.statusPlay
                    repeat: root.statusPlay
                    interval: 100
                    onTriggered:  {
                        entity.preVal = entity.curVal
                        entity.curVal = Qt.rgba(Math.random(),Math.random(),Math.random(),1);
                        colorAnimation.start()
                    }
                }
            }


        ]
    }

    RenderSettings {
        id: external_forward_renderer
        activeFrameGraph: ForwardRenderer {
            camera: camera
            clearColor: "transparent"
        }
    }

    components: [external_forward_renderer]

}
