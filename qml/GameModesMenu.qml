import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Rectangle {
    id:mainRect
    color: "white";
    property int contentWidth:  mainRect.width/3*2;
    property int contentHeight: height/9
    Column{
        id: column
        spacing: parent.contentHeight/2

        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: parent.width/4*3;
        anchors.topMargin: parent.contentHeight;
        anchors.horizontalCenter: parent.horizontalCenter;

        Btn{
            id: classic
            width: mainRect.contentWidth;
            height: mainRect.contentHeight;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("CLASSIC");
            fntSize: height/3;
            onClicked: {
                logic.restart();
                mainLoader.source = "Game.qml"
            }
        }
        Row{
            spacing: 7
            anchors.horizontalCenter: parent.horizontalCenter;
            Btn{
                id: random
                width: mainRect.contentWidth/2-4;
                height: mainRect.contentHeight;
//                anchors.horizontalCenter: parent.horizontalCenter;
                text: qsTr("RANDOM");
                fntSize: height/4;
                disable: true
                onClicked: {
                }
            }
            Btn{
                id: inTime
                width: mainRect.contentWidth/2-4;
                height: mainRect.contentHeight;
//                anchors.horizontalCenter: parent.horizontalCenter;
                text: qsTr("IN TIME");
                fntSize: height/4;
                disable: true
                onClicked: {
                }
            }
        }
        Btn{
            id: guide
            width: mainRect.contentWidth;
            height: mainRect.contentHeight;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("GUIDE");
            fntSize: height/3;
            onClicked: {
//                mainLoader.source = "About.qml"
            }
        }
        Btn{
            id: back
            width: mainRect.contentWidth;
            height: mainRect.contentHeight;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("BACK");
            fntSize: height/3;
            onClicked: mainFlickable.contentX -= mainRect.width
        }
        ClearField{
            width: mainRect.contentWidth;
            height: mainRect.contentHeight;
            anchors.horizontalCenter: parent.horizontalCenter;
            Text{
                anchors.fill: parent
                text: qsTr("WARNING! If you start a new game, the current progress will be lost!")
                color: "darkred"
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                fontSizeMode: Text.Fit;
                font.family: robotoItalic.name
                font.bold: true
                wrapMode: Text.WordWrap;
            }
        }
    }
    FontLoader {
        id: robotoItalic
        source: "qrc:/res/Roboto-LightItalic.ttf"
    }

    focus: true
    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {

//                mainLoader.source = "MainMenu.qml"
            event.accepted = true
        }
    }
    Component.onCompleted: {
        forceActiveFocus();
    }
}
