import QtQuick 2.2
import QtQuick.Controls 1.1
import GameLogic 1.0

ApplicationWindow {
    visible: true
    width: 600
    height: 800
    title: qsTr("Digits")

    GameLogic{
        id: logic
    }

    Loader{
        id:mainLoader
        anchors.fill: parent

    }

    Component.onCompleted: mainLoader.source = "MainMenu.qml"
}
