import QtQuick 2.2
import QtQuick.Layouts 1.1

Rectangle {
    id:menuField
    color: "#fdf9f0";
        Grid{
            id:gridLeft
    //                anchors.fill:parent
            anchors.right: butField.left
            anchors.top: butField.top
            anchors.bottom: butField.bottom
            anchors.margins: 7
            columns: ((menuField.width-butField.width)/2)/butField.cellSize+1
            spacing: 7
            Repeater{
                model: gridLeft.columns*menuField.height/butField.cellSize +1
                delegate: Cell{
                    width: butField.cellSize
                    height: butField.cellSize
                    state: "Delete"
                }
            }
        }


        Rectangle{
            id: butField
            width: cellSize*4+21
            height: menuField.height;
            anchors.horizontalCenter: parent.horizontalCenter;
//            anchors.verticalCenter:  parent.verticalCenter;

            property int cellSize: menuField.width > menuField.height ?  menuField.height/7 :  menuField.width/4*3/4-21;
            color: Qt.rgba(0,0,0,0);

            Column{
                id: column
                spacing: 7

                anchors.horizontalCenter: parent.horizontalCenter;
                Item{
                    width: 1
                    height: 0.1
                }
                Row{
                    id: logo;
                    spacing: 7
                    Image{
                        width: butField.cellSize
//                            menuField.width/4*3/4-28;
                        height: butField.cellSize;
                        fillMode: Image.PreserveAspectFit
//                        verticalAlignment: Image.AlignBottom

                        source: "/logo_D.png"
                    }
                    Image{
                        width: butField.cellSize
                        height: butField.cellSize;
                        fillMode: Image.PreserveAspectFit
//                        verticalAlignment: Image.AlignBottom

                        source: "/logo_G.png"
                    }
                    Image{
                        width: butField.cellSize
                        height: butField.cellSize;
                        fillMode: Image.PreserveAspectFit
//                        verticalAlignment: Image.AlignBottom

                        source: "/logo_T.png"
                    }
                    Image{
                        width: butField.cellSize
                        height: butField.cellSize;
                        fillMode: Image.PreserveAspectFit
//                        verticalAlignment: Image.AlignBottom

                        source: "/logo_S.png"
                    }
                }

                Btn{
                    id: start
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("START");
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
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("OPTIONS");
                    fntSize: height/3;
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                        }
                    }
                }
                Btn{
                    id: about
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("ABOUT");
                    fntSize: height/3;
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                        }
                    }
                }
                Btn{
                    id: exit
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("EXIT");
                    fntSize: height/3;
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: Qt.quit();
                    }
                }
                Grid{
                    id:grid
    //                anchors.fill:parent
                    anchors.horizontalCenter: parent.horizontalCenter;
                    columns: 4
                    spacing: 7
                    Repeater{
                        model: 4*menuField.height/butField.cellSize
                        delegate: Cell{
                            width: butField.cellSize
                            height: butField.cellSize
                            state: "Delete"
                        }
                    }
                }

            }


    //        Column{
    //            spacing: 2;
    //            Rectangle{
    //                id: logoField
    //                width: butField.width;
    //                height: butField.height/4;
    //                color: menuField.color;
    //                Image{
    //                    id: logo;
    //                    fillMode: Image.PreserveAspectFit
    //                    anchors.horizontalCenter: parent.horizontalCenter;
    //                    height: parent.height
    //                    source: "/logo.png"
    //                }
    //            }
    //            Btn{
    //                id: start
    //                width: butField.width;
    //                height: butField.height/7;
    //                anchors.horizontalCenter: parent.horizontalCenter;
    //                text: qsTr("Start");
    //                fntSize: height/3;

    //                MouseArea{
    //                    anchors.fill: parent;
    //                    onClicked: {
    //                        mainLoader.source = "Game.qml"
    //                    }
    //                }
    //            }
    //            Btn{
    //                id: option
    //                width: butField.width;
    //                height: butField.height/7;
    //                anchors.horizontalCenter: parent.horizontalCenter;
    //                text: qsTr("Option");
    //                fntSize: height/3;
    //                MouseArea{
    //                    anchors.fill: parent;
    //                    onClicked: {
    //                    }
    //                }
    //            }
    ////            Btn{
    ////                id: stats
    ////                width: butField.width;
    ////                height: butField.height/7;
    ////                anchors.horizontalCenter: parent.horizontalCenter;
    ////                txt: qsTr("Statistics");
    ////                fntSize: height/3;
    ////                MouseArea{
    ////                    anchors.fill: parent;
    ////                    onClicked: {
    ////                    }

    ////                }
    ////            }
    //            Btn{
    //                id: exit
    //                width: butField.width;
    //                height: butField.height/7;
    //                anchors.horizontalCenter: parent.horizontalCenter;
    //                text: qsTr("Exit");
    //                fntSize: height/3;
    //                MouseArea{
    //                    anchors.fill: parent;
    //                    onClicked: Qt.quit();
    //                }
    //            }
    //        }
        }


        Grid{
            id:gridRight
    //                anchors.fill:parent
            anchors.left: butField.right
            anchors.top: butField.top
            anchors.bottom: butField.bottom
            anchors.margins: 7
            columns: ((menuField.width-butField.width)/2)/butField.cellSize+1
            spacing: 7
            Repeater{
                model: gridRight.columns*menuField.height/butField.cellSize+1
                delegate: Cell{
                    width: butField.cellSize
                    height: butField.cellSize
                    state: "Delete"
                }
            }
        }
}
