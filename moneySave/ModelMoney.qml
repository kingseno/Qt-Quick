import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12

ListModel {
    id: transactionID

    ListElement {
        label:  "10 đ"
        type: "Food"
        note: "Morning"
        url: "qrc:/icon/icon/underline.svg"
        day: 01
        month: 01
        year: 2020
    }

    ListElement {
        label:  "20 đ"
        type: "Bills"
        note: "Electric"
        url: "qrc:/icon/icon/book.svg"
        day: 01
        month: 01
        year: 2020
    }

    ListElement {
        label:  "30 đ"
        type: "Shopping"
        note: "Soap"
        url: "qrc:/icon/icon/shopping-cart.svg"
        day: 01
        month: 01
        year: 2020
    }
}
