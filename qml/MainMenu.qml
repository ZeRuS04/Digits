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

                        source: "/res/logo_D.png"
                    }
                    Image{
                        width: butField.cellSize
                        height: butField.cellSize;
                        fillMode: Image.PreserveAspectFit
//                        verticalAlignment: Image.AlignBottom

                        source: "/res/logo_G.png"
                    }
                    Image{
                        width: butField.cellSize
                        height: butField.cellSize;
                        fillMode: Image.PreserveAspectFit
//                        verticalAlignment: Image.AlignBottom

                        source: "/res/logo_T.png"
                    }
                    Image{
                        width: butField.cellSize
                        height: butField.cellSize;
                        fillMode: Image.PreserveAspectFit
//                        verticalAlignment: Image.AlignBottom

                        source: "/res/logo_S.png"
                    }
                }


                Btn{
                    id: continueGame
                    width: grid.width;
                    height: butField.cellSize
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
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("NEW GAME");
                    fntSize: height/3;
                    onClicked: {
                        mainLoader.source = "GameModesMenu.qml"
                    }
                }
//                Btn{
//                    id: option
//                    width: grid.width;
//                    height: butField.cellSize
//                    anchors.horizontalCenter: parent.horizontalCenter;
//                    text: qsTr("OPTIONS");
//                    fntSize: height/3;
//                    onClicked: {
//                        mainLoader.source = "Option.qml"
//                    }
//                }
                Btn{
                    id: about
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("ABOUT");
                    fntSize: height/3;
                    onClicked: {
                        mainLoader.source = "About.qml"
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
        }


        Grid{
            id:gridRight
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
