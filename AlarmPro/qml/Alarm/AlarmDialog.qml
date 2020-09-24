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
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

Dialog {
    id: alarmDialog
    title: "Add new alarm"
    width: parent.width * 0.8
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property AlarmModel alarmModel

    function formatNumber(number) {
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }

    onAccepted: {

        alarmModel.append({
            "hour": hoursTumbler.currentIndex,
            "minute": minutesTumbler.currentIndex,
//            "day": dayTumbler.currentIndex + 1,
//            "month": monthTumbler.currentIndex + 1,
//            "year": yearTumbler.years[yearTumbler.currentIndex],
              "day": 0,
              "month": 0,
              "year": 0,
            "activated": true,
            "label": descriptionTextField.text,
            "repeat": false,
            "daysToRepeat": [
                { "dayOfWeek": 0, "repeat": false },
                { "dayOfWeek": 1, "repeat": false },
                { "dayOfWeek": 2, "repeat": false },
                { "dayOfWeek": 3, "repeat": false },
                { "dayOfWeek": 4, "repeat": false },
                { "dayOfWeek": 5, "repeat": false },
                { "dayOfWeek": 6, "repeat": false }
            ],
        })
        alarmListView.sendInfoToCplusplus()
    }
    onRejected: alarmDialog.close()

    contentItem: ColumnLayout {
        width: parent.width

        RowLayout {
            id: rowTumbler
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 40

            Tumbler {
                id: hoursTumbler
                model: 24
                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                }
            }
            Text {
                text: qsTr(":")
                color: "white"
            }
            Tumbler {
                id: minutesTumbler
                model: 60
                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                }
            }
        }

        TextField {
            id: descriptionTextField
            Layout.fillWidth: true
            placeholderText: qsTr("Enter description here")
            text: ""
        }
//        RowLayout {
//            id: datePicker

//            Layout.leftMargin: 20
//            property alias dayTumbler: dayTumbler
//            property alias monthTumbler: monthTumbler
//            property alias yearTumbler: yearTumbler

//            readonly property var days: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

//            Tumbler {
//                id: dayTumbler

//                function updateModel() {
//                    // Populate the model with days of the month. For example: [0, ..., 30]
//                    var previousIndex = dayTumbler.currentIndex
//                    var array = []
//                    var newDays = datePicker.days[monthTumbler.currentIndex]
//                    for (var i = 1; i <= newDays; ++i)
//                        array.push(i)
//                    dayTumbler.model = array
//                    dayTumbler.currentIndex = Math.min(newDays - 1, previousIndex)
//                }

//                Component.onCompleted: updateModel()

//                delegate: TumblerDelegate {
//                    text: formatNumber(modelData)
//                }
//            }
//            Text {
//                text: qsTr("/")
//                color: "white"
//            }
//            Tumbler {
//                id: monthTumbler

//                onCurrentIndexChanged: dayTumbler.updateModel()

//                model: 12
//                delegate: TumblerDelegate {
//                    text: window.locale.standaloneMonthName(modelData, Locale.ShortFormat)
//                }
//            }
//            Text {
//                text: qsTr("/")
//                color: "white"
//            }
//            Tumbler {
//                id: yearTumbler

//                // This array is populated with the next three years. For example: [2018, 2019, 2020]
//                readonly property var years: (function() {
//                    var currentYear = new Date().getFullYear()
//                    return [0, 1, 2].map(function(value) { return value + currentYear; })
//                })()

//                model: years
//                delegate: TumblerDelegate {
//                    text: formatNumber(modelData)
//                }
//            }
//        }
    }
}
