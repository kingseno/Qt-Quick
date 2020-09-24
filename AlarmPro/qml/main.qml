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

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.calendar 1.0
import "./Alarm"
import "./CountDown"
import "./StopWatch"
import BackEnd 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 420
    height: 720
    maximumWidth: 420
    maximumHeight: 720
    minimumWidth: 420
    minimumHeight: 720
    title: qsTr(" Alarm13 Super ProMax")

    Config {
        id: config
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Alarm {
            id: alarm
        }

        StopWatch {
            id: stopWatch
        }

        CountDown {
            id: countDown
        }
    }

    header: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            icon.name: "bell-regular"
            icon.width: 21
            icon.height: 24
        }
        TabButton {
            icon.name: "stopwatch-solid"
            icon.width: 21
            icon.height: 24
        }
        TabButton {
            icon.name: "hourglass-regular"
            icon.width: 21
            icon.height: 24
        }
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


}
