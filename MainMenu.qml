import QtQuick 2.2

Rectangle {
    id:menuField
    Rectangle{
        id: butField
        width: parent.width/4*3;
        height: parent.height;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter:  parent.verticalCenter;
        color: Qt.rgba(0,0,0,0);
        Column{
            spacing: 2;
//            Rectangle{
//                id: wTheF
//                width: butField.width;
//                height: butField.height/4;
//                color: menuField.bgnColor;
//                Image{
//                    id: logo;
//                    fillMode: Image.PreserveAspectFit
//                    anchors.horizontalCenter: parent.horizontalCenter;
//                    height: parent.height
//                    source: "/logo.png"
//                }
//            }
            Btn{
                id: start
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: qsTr("Start");
                fntSize: height/3;

                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        mainLoader.source = "Game.qml"
                    }
                }
            }
            Btn{
                id: option
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: qsTr("Option");
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                    }
                }
            }
//            Btn{
//                id: stats
//                width: butField.width;
//                height: butField.height/7;
//                anchors.horizontalCenter: parent.horizontalCenter;
//                txt: qsTr("Statistics");
//                fntSize: height/3;
//                MouseArea{
//                    anchors.fill: parent;
//                    onClicked: {
//                    }

//                }
//            }
            Btn{
                id: exit
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: qsTr("Exit");
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: Qt.quit();
                }
            }
        }
    }


}
