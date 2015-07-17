import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Button{
    id: btn
    Rectangle{
        id: colorField
        anchors.fill: parent
        color: Qt.rgba(0.99, 0.80, 0.51, 0.2)
        Behavior on color {
            ColorAnimation {
                duration: 300
            }
        }
        radius: 4
    }
    state: "Default"
    states: [
        State{
            name: "Default"
            PropertyChanges {
                target: colorField
                color: Qt.rgba(0.99, 0.80, 0.51, 0.2)
            }
        },
        State{
            name: "Red"
            PropertyChanges {
                target: colorField
                color: Qt.rgba(0.99, 0.00, 0.00, 0.5)
            }
        },
        State{
            name: "Green"
            PropertyChanges {
                target: colorField
                color: Qt.rgba(0.00, 0.99, 0.00, 0.5)
            }
        }
    ]
//    transitions: [
//        Transition {
//            from: ""; to: ""; reversible: true
//            ColorAnimation { duration: 500 }
//           }
//        Transition {
//                from: ""; to: "Red"; reversible: true
//                ColorAnimation { duration: 500 }
//        }
//    ]
}
