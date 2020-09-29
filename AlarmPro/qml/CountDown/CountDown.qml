/****************************************************************************
** Project                  = Alarm13 Super ProMax
** Author                   = Dinh Pham
** Version                  = V1.0.0
** Date                     = 23/09/2020
**
*****************************************************************************
** Purpose of this file:
**
*****************************************************************************
** Lisense
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** Copyright (C) 2020 by Dinh Pham
**
*****************************************************************************
**                      Revision Control History
** V1.0.0:  23/09/2020  : Initial version.
**
****************************************************************************/

import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

import Qt3D.Animation 2.12
import Qt3D.Core 2.12
import Qt3D.Extras 2.12
import Qt3D.Input 2.12
import Qt3D.Render 2.12
import Qt3D.Logic 2.12
import QtQuick.Scene3D 2.15

Item {
    Scene3D  {
        id: scene
        anchors.fill: parent

        Entity {
            id: root
            Camera{
                id: mainCamera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 100
                aspectRatio: 1820 / 1080
                nearPlane: 0.1
                farPlane: 1000.0
                position: Qt.vector3d(10, 10, 10)
                upVector: Qt.vector3d(0, 1, 0)
                viewCenter: Qt.vector3d(0.0, 20.0, 0.0)

            }

            OrbitCameraController {
                camera: mainCamera
            }

            Entity{
                id: entity
                property color preVal;
                property color curVal;
                components: [
                    Mesh{
                        id: mesh
                        source: "qrc:/icons/alarm/32x32/plane3D/plane.obj"
                    },
                    PhongMaterial{
                        id: phongMaterial
                        diffuse: "white"
                        ambient: "lightyellow"
                    }
                    ,
                    Transform{
                        id: transform
                        scale: 1
//                        translation: Qt.vector3d(0.0, 0.0, 0.0)

                        SequentialAnimation {
                            running: true
                            loops: Animation.Infinite

                            Vector3dAnimation{
                                from: Qt.vector3d(0.0, 20.0, 0.0)
                                to: Qt.vector3d(0.0, -8.0, 0.0)
                                duration: 5000
                                target: mainCamera
                                properties: "viewCenter"
                            }

                            NumberAnimation{
                                from: 100
                                to: 60
                                duration: 500
                                target: mainCamera
                                properties: "fieldOfView"
                            }


                            NumberAnimation{
                                from: 0
                                to: 300
                                duration: 3000
                                target: transform
                                properties: "rotationY"
                            }

                            PauseAnimation {
                                duration: 500
                            }

                            Vector3dAnimation{
                                from: Qt.vector3d(0.0, -8.0, 0.0)
                                to: Qt.vector3d(10.0, -8.0, 0.0)
                                duration: 100
                                target: mainCamera
                                properties: "viewCenter"
                            }

                            NumberAnimation{
                                from: 60
                                to: 100
                                duration: 1
                                target: mainCamera
                                properties: "fieldOfView"
                            }

                            NumberAnimation{
                                from: 300
                                to: 360
                                duration: 1
                                target: transform
                                properties: "rotationY"
                            }

                        }

//                        NumberAnimation on scale{
//                            running: true
//                            loops: Animation.Infinite
//                            from: 0.5; to: 1
//                            duration: 800
//                        }
                        ColorAnimation{
                            id: colorAnimation
                            target: phongMaterial
                            properties: "diffuse"
                            from: entity.preVal
                            to: entity.curVal
                            duration: 500
                        }
                        Timer{
                            running: true
                            repeat: true
                            interval: 400
                            onTriggered:  {
                                entity.preVal = entity.curVal
                                entity.curVal = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
                                colorAnimation.start()
                            }
                        }
                    }
                ]
            }

            RenderSettings {
                id: external_forward_renderer
                activeFrameGraph: ForwardRenderer {
                    camera: mainCamera
                    clearColor: "transparent"
                }
            }

            InputSettings {
                id: input
            }

            components: [external_forward_renderer, input]
        }

    }
}
