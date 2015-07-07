import QtQuick 2.2
import QtQuick.Layouts 1.1

Rectangle {
    id:options
    color: "#fdf9f0";

    Column{
        id: optColumn
        anchors.fill: parent
        anchors.margins: parent.height < parent.width ? parent.height/10 : parent.width/10
        Text{
            id: title
            text: qsTr("OPTIONS");
            width: parent.width
            horizontalAlignment: Text.AlignHCenter;
            font.pixelSize: 30;
            font.family: "Arial"
            font.bold: true
            wrapMode: Text.WordWrap;
        }
//        Btn{
//            id: deleteSaves
//            width: grid.width;
//            height: butField.cellSize
//            anchors.horizontalCenter: parent.horizontalCenter;
//            text: qsTr("NEW GAME");
//            fntSize: height/3;
//            onClicked: {
//                mainLoader.source = "GameModesMenu.qml"
//            }
//        }
    }
}
