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

// Populate the model with some sample data.
ListModel {
    id: alarmModel

    Component.onCompleted:
        alarmListView.model.append(config.loadAlarms().config)
//    ListElement {
//        hour: 6
//        minute: 0
//        day: 2
//        month: 8
//        year: 2018
//        activated: true
//        label: "Wake up"
//        repeat: true
//        daysToRepeat: [
//            ListElement { dayOfWeek: 0; repeat: false },
//            ListElement { dayOfWeek: 1; repeat: false },
//            ListElement { dayOfWeek: 2; repeat: false },
//            ListElement { dayOfWeek: 3; repeat: false },
//            ListElement { dayOfWeek: 4; repeat: false },
//            ListElement { dayOfWeek: 5; repeat: false },
//            ListElement { dayOfWeek: 6; repeat: false }
//        ]
//    }
//    ListElement {
//        hour: 6
//        minute: 0
//        day: 3
//        month: 8
//        year: 2018
//        activated: true
//        label: "Wake up"
//        repeat: true
//        daysToRepeat: [
//            ListElement { dayOfWeek: 0; repeat: true },
//            ListElement { dayOfWeek: 1; repeat: true },
//            ListElement { dayOfWeek: 2; repeat: true },
//            ListElement { dayOfWeek: 3; repeat: true },
//            ListElement { dayOfWeek: 4; repeat: true },
//            ListElement { dayOfWeek: 5; repeat: false },
//            ListElement { dayOfWeek: 6; repeat: false }
//        ]
//    }
//    ListElement {
//        hour: 7
//        minute: 0
//        day: 3
//        month: 8
//        year: 2018
//        activated: false
//        label: "Exercise"
//        repeat: true
//        daysToRepeat: [
//            ListElement { dayOfWeek: 0; repeat: true },
//            ListElement { dayOfWeek: 1; repeat: true },
//            ListElement { dayOfWeek: 2; repeat: true },
//            ListElement { dayOfWeek: 3; repeat: true },
//            ListElement { dayOfWeek: 4; repeat: true },
//            ListElement { dayOfWeek: 5; repeat: true },
//            ListElement { dayOfWeek: 6; repeat: true }
//        ]
//    }
//    ListElement {
//        hour: 5
//        minute: 15
//        day: 1
//        month: 9
//        year: 2018
//        activated: true
//        label: ""
//        repeat: false
//        daysToRepeat: [
//            ListElement { dayOfWeek: 0; repeat: false },
//            ListElement { dayOfWeek: 1; repeat: false },
//            ListElement { dayOfWeek: 2; repeat: false },
//            ListElement { dayOfWeek: 3; repeat: false },
//            ListElement { dayOfWeek: 4; repeat: false },
//            ListElement { dayOfWeek: 5; repeat: false },
//            ListElement { dayOfWeek: 6; repeat: false }
//        ]
//    }
//    ListElement {
//        hour: 5
//        minute: 45
//        day: 3
//        month: 9
//        year: 2018
//        activated: false
//        label: ""
//        repeat: false
//        daysToRepeat: [
//            ListElement { dayOfWeek: 0; repeat: false },
//            ListElement { dayOfWeek: 1; repeat: false },
//            ListElement { dayOfWeek: 2; repeat: false },
//            ListElement { dayOfWeek: 3; repeat: false },
//            ListElement { dayOfWeek: 4; repeat: false },
//            ListElement { dayOfWeek: 5; repeat: false },
//            ListElement { dayOfWeek: 6; repeat: false }
//        ]
//    }
}
