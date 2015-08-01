import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle{
    id: mainRect
    color: "#3283ff"

    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
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
        spacing: 7
        Timer{
            id: headerTimer1
            interval: 4000; running: true; repeat: true
            onTriggered: {
                cell_1.rotate(false);
                if(cell_1.state == "UpSide")
                    cell_1.downSidetext = mainRect.getRandomInt(1,9);
            }
        }
        Timer{
            id: headerTimer2
            interval: 4500; running: false; repeat: true
            onTriggered: {
                cell_2.rotate(false);
                if(cell_2.state == "UpSide")
                    cell_2.downSidetext = mainRect.getRandomInt(1,9);
            }
        }
        Timer{
            id: headerTimer3
            interval: 4000; running: false; repeat: true
            onTriggered: {
                cell_3.rotate(false);
                if(cell_3.state == "UpSide")
                    cell_3.downSidetext = mainRect.getRandomInt(1,9);
            }
        }
        Timer{
            id: headerTimer4
            interval: 4500; running: true; repeat: true
            onTriggered: {
                cell_4.rotate(false);
                if(cell_4.state == "UpSide")
                    cell_4.downSidetext = mainRect.getRandomInt(1,9);
            }
        }
        Timer{
            interval: 1000; running: true; repeat: false
            onTriggered: {
                headerTimer2.start()
                headerTimer3.start()
            }
        }
        Cell{
            id: cell_1
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "1"
            width: mainRect.height/3; height: mainRect.height/3;
//            state: "UpSide"
        }


        Cell{
            id: cell_2
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "5"
            width: mainRect.height/3; height: mainRect.height/3;
//            state: "UpSide"
        }
        Cell{
            id: cell_3
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "5"
            width: mainRect.height/3; height: mainRect.height/3;
//            state: "UpSide"
        }
        Cell{
            id: cell_4
            upSideColor: "#3283ff"
            downSideColor: "white"
            downSidetextColor: "#3283ff"
            downSidetext: "9"
            width: mainRect.height/3; height: mainRect.height/3;
//            state: "UpSide"
        }
    }
    Component.onCompleted: {
        cell_1.rotate(false);
        cell_4.rotate(false);
    }
}
