import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle{
    id: mainRect
    color: "#3283ff"
    FontLoader {
        id: robotoRegular
        source: "qrc:/res/Roboto-Regular.ttf"
    }
    FontLoader {
        id: robotoItalic
        source: "qrc:/res/Roboto-LightItalic.ttf"
    }

    BorderImage {
        id: header
        source: "qrc:/headerBorder.png"
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
        height: parent.height+10

        border.left: 0; border.top: 0
        border.right: 0; border.bottom: 10
    }



    Row{
        anchors.fill: parent;
        layoutDirection: Qt.RightToLeft
        spacing: mainRect.height/7;

        anchors.rightMargin: mainRect.width/7
        Text{
            id: headerText2
            height: parent.height
//            anchors.fill: parent;
            color: "white"
            text: "new";
            horizontalAlignment: Text.AlignRight;
            verticalAlignment: Text.AlignVCenter;
            font.pixelSize: mainRect.height/3;
            font.family: robotoItalic.name
            font.italic: true
            wrapMode: Text.WordWrap;
        }
        Text{
            id: headerText
            height: parent.height
            color: "white"
            text: "Digits";
            horizontalAlignment: Text.AlignRight;
            verticalAlignment: Text.AlignVCenter;
            font.pixelSize: mainRect.height/3;
            font.family: robotoRegular.name
            font.bold: true
            wrapMode: Text.WordWrap;
        }

    }

    Grid{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: mainRect.width/7
        columns: 2
        rows: 2
        spacing: 5
        Cell{
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "1"
            width: mainRect.height/3; height: mainRect.height/3;
        }
        Cell{
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "5"
            width: mainRect.height/3; height: mainRect.height/3;
        }
        Cell{
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "5"
            width: mainRect.height/3; height: mainRect.height/3;
        }
        Cell{
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "9"
            width: mainRect.height/3; height: mainRect.height/3;
        }
    }

}
