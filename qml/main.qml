import QtQuick 2.2
import QtQuick.Controls 1.1
import GameLogic 1.0

ApplicationWindow {
    visible: true
    width: 600;
    height: 800;
    title: qsTr("Digits");


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

    Loader{
        id:mainLoader
        anchors.fill: parent;
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
