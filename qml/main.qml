import QtQuick 2.2
import QtQuick.Controls 1.1
import GameLogic 1.0

ApplicationWindow {
    visible: true
    width: 600;
    height: 800;
    title: qsTr("Digits");

    FontLoader {
        id: robotoRegular
        source: "qrc:/res/Roboto-Regular.ttf"
    }
    FontLoader {
        id: robotoItalic
        source: "qrc:/res/Roboto-LightItalic.ttf"
    }


    GameLogic{
        id: logic
        function integerDivision(x, y){
            return (x-x%y)/y
        }
        function secToString(time) {
            var seconds = time%60;
            if(seconds < 10)
                seconds = "0" + String(seconds)
            else
                seconds = String(seconds)
            time = integerDivision(time,60);
            var minutes = time%60;
            if(minutes < 10)
                minutes = "0" + String(minutes)
            else
                minutes = String(minutes)
            time = integerDivision(time,60);
            var hours = time%24;
            var days = integerDivision(time,24);
            var string = "";
            if (days!=0) {
                    string = days +":"+ hours +":"+  minutes +":"+ seconds;
            } else if (hours!=0) {
                    string = hours +":"+ minutes +":"+ seconds;
            } else {
                    string = minutes +":"+ seconds;
            }
            return string;
        }
    }

//    Rectangle{
//        id: bannerField
//        anchors.top: parent.top
//        anchors.left: parent.left
//        anchors.right: parent.right
//        height: parent.height < 400 ? 32 : (parent.height >= 400)&&(parent.height  < 720) ? 50 : 90
//        color: "black"
//        Text{
//            id: buttonText
//            anchors.fill: parent;
//            text: qsTr("Ad unit");
//            horizontalAlignment: Text.AlignHCenter;
//            verticalAlignment: Text.AlignVCenter;
//            font.pixelSize: height/3;
//            font.family: "Arial"
//            font.bold: true
//            color: "white"
//            wrapMode: Text.WordWrap;
//        }
//    }

    Loader{
        id:mainLoader
        anchors.top: parent.top
//        anchors.top: bannerField.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom;
        onLoaded: {
            logic.openQmlPage(source);
        }
    }
    Connections{
        target: logic
        onEndGame: mainLoader.source = "End.qml";
    }

    Component.onCompleted: mainLoader.source = "MainMenu.qml";
}
