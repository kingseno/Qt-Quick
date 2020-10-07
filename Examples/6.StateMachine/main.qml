import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQml.StateMachine 1.0 as DSM

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: rect
        width: 100
        height: 100
        Button {
            anchors.fill: parent
            id: button
            text: "Initial state"
            DSM.StateMachine {
                id: stateMachine
                initialState: state
                running: true
                DSM.State {
                    id: state
                    DSM.SignalTransition {
                        targetState: finalState
                        signal: button.clicked
                    }
                }
                DSM.FinalState {
                    id: finalState
                }
                onFinished: button.text = "Final state"
            }
        }
    }
}
