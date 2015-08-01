import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1


Rectangle {
    id:menuField
    color: "white";

    Flickable{
        id: mainFlickable
        interactive: false
        anchors.left: parent.left; anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        height: menuField.height/5*4;
        contentHeight: field.height; contentWidth: field.width;
        contentX: menuField.width
        Behavior on contentX {
            NumberAnimation { duration: 300 }
        }
        Rectangle{
            id: field
            width: menuField.width*3
            height: mainFlickable.height
            anchors.bottom: parent.bottom

            //======== About ===========
            About{
                id: about
                anchors.left: parent.left;   anchors.top: parent.top
                width: menuField.width; height: parent.height
            }
            //==========================


            //===== WelcomeMenu ========
            WelcomeMenu{
                id: welcomeMenu
                anchors.left: about.right;   anchors.top: parent.top
                width: menuField.width; height: parent.height
            }
            //==========================

            //===== GamesModeMenu ======
            GameModesMenu{
                anchors.left: welcomeMenu.right;   anchors.top: parent.top
                width: menuField.width; height: parent.height
            }
            //==========================
        }
    }
        MenuHeader{
            id: menuHeader
            anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
            height: parent.height/5
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
