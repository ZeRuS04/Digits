import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1


Rectangle {
    id:menuField
    color: "white";

    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation
    property int contentWidth: width > height ?  menuField.width/3 :  menuField.width/3*2;
    property int contentHeight: height/9
    MenuHeader{
        id: menuHeader
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
        height: parent.height/5
    }

    Flow{
        id: column
        spacing: parent.contentHeight/2

        anchors.top: menuHeader.bottom
        anchors.bottom: parent.bottom

        width: parent.width/4*3
        anchors.topMargin: parent.contentHeight
        anchors.horizontalCenter: parent.horizontalCenter;

        Btn{
            id: continueGame
            width: menuField.contentWidth;
            height: menuField.contentHeight
//            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("CONTINUE");
            fntSize: height/3;
            disable: !logic.haveSaves()
            onClicked: {
                mainLoader.source = "Game.qml"
            }

        }
        Btn{
            id: start
            width: menuField.contentWidth;
            height: menuField.contentHeight
//            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("NEW GAME");
            fntSize: height/3;
            onClicked: {
                mainLoader.source = "GameModesMenu.qml"
            }
        }
//                Btn{
//                    id: option
//                    width: menuField.contentWidth;
//                    height: menuField.contentHeight
//                    anchors.horizontalCenter: parent.horizontalCenter;
//                    text: qsTr("OPTIONS");
//                    fntSize: height/3;
//                    onClicked: {
//                        mainLoader.source = "Option.qml"
//                    }
//                }
        Btn{
            id: about
            width: menuField.contentWidth;
            height: menuField.contentHeight
//            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("ABOUT");
            fntSize: height/3;
            onClicked: {
                mainLoader.source = "About.qml"
            }
        }
        Btn{
            id: exit
            width: menuField.contentWidth;
            height: menuField.contentHeight
//            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("EXIT");
            fntSize: height/3;
            MouseArea{
                anchors.fill: parent;
                onClicked: Qt.quit();
            }
        }

    }





//        Rectangle{
//            id: butField
//            width: cellSize*4+21
//            height: menuField.height;
//            anchors.horizontalCenter: parent.horizontalCenter;
////            anchors.verticalCenter:  parent.verticalCenter;

//
//            color: Qt.rgba(0,0,0,0);


//        }


}
