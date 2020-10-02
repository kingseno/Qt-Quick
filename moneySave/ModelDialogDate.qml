import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12
import QtQml 2.15

Dialog {
    id: transactionDateDialog
    title: "Selecte date"
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property ModelMoney moneyMoney

    function formatNumber(number) {
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }

    onAccepted: {
        moneyMoney.append({
            "day": dayTumbler.currentIndex + 1,
            "month": monthTumbler.currentIndex + 1,
            "year": yearTumbler.years[yearTumbler.currentIndex],

        })
    }
    onRejected: transactionDateDialog.close()

    contentItem: RowLayout {
        id: datePicker

        Layout.leftMargin: 20

        property alias dayTumbler: dayTumbler
        property alias monthTumbler: monthTumbler
        property alias yearTumbler: yearTumbler

        readonly property var days: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        readonly property var months: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

        Tumbler {
            id: dayTumbler

            function updateModel() {
                // Populate the model with days of the month. For example: [0, ..., 30]
                var previousIndex = dayTumbler.currentIndex
                var array = []
                var newDays = datePicker.days[monthTumbler.currentIndex]
                for (var i = 1; i <= newDays; ++i)
                    array.push(i)
                dayTumbler.model = array
                dayTumbler.currentIndex = Math.min(newDays - 1, previousIndex)
            }

            Component.onCompleted: updateModel()

            delegate: TumblerDelegate {
                text: formatNumber(modelData)
            }
        }
        Tumbler {
            id: monthTumbler

            //onCurrentIndexChanged: dayTumbler.updateModel()

            model: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

//            delegate: TumblerDelegate {
//                text: datePicker.months[monthTumbler.currentIndex]
//            }
        }
        Tumbler {
            id: yearTumbler

            // This array is populated with the next three years. For example: [2018, 2019, 2020]
            readonly property var years: (function() {
                var currentYear = new Date().getFullYear()
                return [0, 1, 2].map(function(value) { return value + currentYear - 1; })
            })()

            model: years
            delegate: TumblerDelegate {
                text: formatNumber(modelData)
            }
        }
    }
}
