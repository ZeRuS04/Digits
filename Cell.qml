import QtQuick 2.0

Rectangle {
    id: rect
    height: width
    property int n;

    border.color: "#845a00"
    Text{
        id: num
        anchors.centerIn: parent
//        font.pointSize: 14
        font.pixelSize: rect.height/2
        text: rect.modelData == 0 ? "" : parent.n
    }

    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true
    }

    state: "Default"
    states: [
        State{
            name: "Default"
            when: rect.n != 0
            PropertyChanges {
                target: rect
                color: "skyblue"
                border.width: 1
                radius: rect.width/10
            }
            PropertyChanges {
                target: num
                text: rect.n
            }
        },
//        State{
//            name: "Select"
//            when: ma.containsMouse
//            PropertyChanges {
//                target: rect
//                color: "skyblue"
//                border.width: 2
//                radius: width/10
//            }
//            PropertyChanges {
//                target: num
//                text: rect.n
//            }
//        },
        State{
            name: "Check"
            PropertyChanges {
                target: rect
                color: "lightgreen"
                border.width: 2
                radius: width/10
            }
            PropertyChanges {
                target: num
                text: rect.n
            }
        },
        State{
            name: "Delete"

            PropertyChanges {
                target: rect
                color: "#6b6d6d"
                border.width: 0
                radius: 0
            }
            PropertyChanges {
                target: num
                text: ""
            }
        }
    ]



}
