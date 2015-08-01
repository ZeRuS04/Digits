import QtQuick 2.0

Rectangle {
    id: mainRect
    color: "white"
    property int contentWidth:  mainRect.width/3*2;
    property int contentHeight: height/9
    Column{
        id: column
        spacing: parent.contentHeight/2

        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: parent.width/4*3
        anchors.topMargin: parent.contentHeight
        anchors.horizontalCenter: parent.horizontalCenter;

        Btn{
            id: continueGame
            width: mainRect.contentWidth;
            height: mainRect.contentHeight
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("CONTINUE");
            fntSize: height/3;
            disable: !logic.haveSaves()
            onClicked: {
                mainLoader.source = "Game.qml"
            }

        }
        Btn{
            id: start
            width: mainRect.contentWidth;
            height: mainRect.contentHeight
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("NEW GAME");
            fntSize: height/3;
            onClicked: {
                mainFlickable.contentX += mainRect.width;
//                mainLoader.source = "GameModesMenu.qml"
            }
        }

        Btn{
            id: about
            width: mainRect.contentWidth;
            height: mainRect.contentHeight
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("ABOUT");
            fntSize: height/3;
            onClicked: {
                mainFlickable.contentX = 0;
//                mainLoader.source = "About.qml"
            }
        }
        Btn{
            id: exit
            width: mainRect.contentWidth;
            height: mainRect.contentHeight
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("EXIT");
            fntSize: height/3;
            onClicked: Qt.quit();
        }

    }
}

