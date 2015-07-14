import QtQuick 2.0

Rectangle {
    id: rect

    property int n;
    property bool blocked: false
    property string upSideColor: "black"
    property string downSideColor: "white"
    property string downSidetextColor: "black"
    property string downSidetext: ""
    property int duration: 500
    property string axis: "y"
    function rotate(){
        upSide.angle += 180
        downSide.angle += 180
        timer.start()
    }

    BorderImage {

        anchors.fill: parent
        source: "qrc:/borderInShadow.png"
        border.left: 3; border.top: 3
        border.right: 3; border.bottom: 3
    }

    Timer {
        id: timer
        interval: rect.duration/2; running: false; repeat: false
        onTriggered: {
            if(parent.state ==  "UpSide")
                parent.state =  "DownSide"
            else
                parent.state =  "UpSide"
        }
    }
    FontLoader {
        id: robotoItalic
        source: "qrc:/res/Roboto-LightItalic.ttf"
    }

    Rectangle{
        id: downSide
        color: rect.downSideColor
        anchors.centerIn: parent
        width: parent.width; height: parent.height
        property int angle: 0
        transform: Rotation {
            origin.x: downSide.width / 2
            origin.y: downSide.height / 2
            axis {
               x: rect.axis == "x" ? 1 : 0;
               y: rect.axis == "y" ? 1 : 0;
               z: rect.axis == "z" ? 1 : 0;
            }
            angle: downSide.angle
            Behavior on angle {
                NumberAnimation { duration: rect.duration }
            }
        }
        BorderImage {

            source: "qrc:/borderShadow.png"

            anchors.centerIn: parent
            width: parent.width+10; height: parent.height+10
            border.left: 3; border.top: 3
            border.right: 3; border.bottom: 3

            Text{
                id: buttonText
                text: downSidetext
                anchors.fill: parent
                color: rect.downSidetextColor
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                font.pixelSize: rect.height/2;
                font.family: robotoItalic.name;
            }
        }
    }
    Rectangle{
        id: upSide
        anchors.centerIn: parent
        width: parent.width; height: parent.height
        color: rect.upSideColor
        smooth: true
        property int angle: 180
        transform: Rotation {
            origin.x: upSide.width / 2
            origin.y: upSide.height / 2
            axis {
                x: rect.axis == "x" ? 1 : 0;
                y: rect.axis == "y" ? 1 : 0;
                z: rect.axis == "z" ? 1 : 0;
            }
            angle: downSide.angle
            Behavior on angle {
                NumberAnimation { duration: rect.duration }
            }
        }

    }


    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            rect.rotate();
        }
    }



    state:"DownSide"
    states: [
        State{
            name: "UpSide";
            PropertyChanges {
                target: upSide
                visible: true
            }
            PropertyChanges {
                target: downSide
                visible: false
            }
        },
        State{
            name: "DownSide";
            PropertyChanges {
                target: downSide
                visible: true
            }
            PropertyChanges {
                target: upSide
                visible: false
            }
        }
    ]

//    Text{
//        id: num
//        anchors.centerIn: parent
//        font.pixelSize: rect.height/2
//        text: rect.modelData == 0 ? "" : parent.n
//    }

//    MouseArea{
//        id: ma
//        anchors.fill: parent
//        hoverEnabled: true

//    }

//    state: "Default"
//    states: [
//        State{
//            name: "Default"
//            when: rect.n != 0
//            PropertyChanges {
//                target: rect
//                color: "skyblue"
//                border.width: 1
//                radius: rect.width/10
//            }
//            PropertyChanges {
//                target: num
//                text: rect.n
//            }
//        },
//        State{
//            name: "Highlighted"
//            PropertyChanges {
//                target: rect
//                color: "orange"
//                border.width: 2
//                radius: width/10
//            }
//            PropertyChanges {
//                target: num
//                text: rect.n
//            }
//        },
//        State{
//            name: "Check"
//            PropertyChanges {
//                target: rect
//                color: "lightgreen"
//                border.width: 2
//                radius: width/10
//            }
//            PropertyChanges {
//                target: num
//                text: rect.n
//            }
//        },
//        State{
//            name: "Delete"

//            PropertyChanges {
//                target: rect
//                color: "#6b6d6d"
//                border.width: 0
//                radius: 0
//            }
//            PropertyChanges {
//                target: num
//                text: ""
//            }
//        }
//    ]
}
