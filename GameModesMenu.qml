import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
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
                    id: continueGame
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("CLASSIC");
                    fntSize: height/3;
                    onClicked: {
                        logic.restart()
                        mainLoader.source = "Game.qml"
                    }

                }
                Row{
                    spacing: 7
                    anchors.horizontalCenter: parent.horizontalCenter;
                    Btn{
                        id: random
                        width: grid.width/2-4;
                        height: butField.cellSize

                        text: qsTr("RANDOM");
                        fntSize: height/3;
                        disable: true
                        onClicked: {
                        }
                    }
                    Btn{
                        id: inTime
                        width: grid.width/2-3;
                        height: butField.cellSize
//                        anchors.horizontalCenter: parent.horizontalCenter;
                        text: qsTr("IN TIME");
                        disable: true
                        fntSize: height/3;
                        MouseArea{
                            anchors.fill: parent;
                            onClicked: {
                            }
                        }
                    }
                }


                Btn{
                    id: guide
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("GUIDE");
                    fntSize: height/3;
                    onClicked: mainLoader.source = "Guide.qml"

                }
                Btn{
                    id: exit
                    width: grid.width;
                    height: butField.cellSize
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: qsTr("BACK");
                    fntSize: height/3;
                    onClicked: mainLoader.source = "MainMenu.qml"

                }
                ClearField{
                    width: grid.width;
                    height: butField.cellSize
                    Text{
                        anchors.fill: parent
                        text: qsTr("WARNING! If you start a new game, the current progress will be lost!")
                        color: "darkred"
                        horizontalAlignment: Text.AlignHCenter;
                        verticalAlignment: Text.AlignVCenter;
                        fontSizeMode: Text.Fit;
                        font.family: "Arial"
                        font.bold: true
                        wrapMode: Text.WordWrap;
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
        focus: true
        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {

                mainLoader.source = "MainMenu.qml"
                event.accepted = true
            }
        }
        Component.onCompleted: {
            forceActiveFocus();
        }
}
