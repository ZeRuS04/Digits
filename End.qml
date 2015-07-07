import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: mainRect
    anchors.fill: parent
    color: "#fdf9f0";
    Column{
        anchors.horizontalCenter: parent.horizontalCenter

        Label{
            width: mainRect.width
            height: mainRect.height/6
            text: qsTr("Congratulations!")
            color: "red"
            font.bold: true
            font.pixelSize: height/3;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Label{
            width: mainRect.width
            height: mainRect.height/10
            text: qsTr("You result:")
            color: "blue"
            font.bold: true
            font.pixelSize: height/3;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Row{
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Label{
                text: qsTr("Time: ") + logic.secToString(logic.time)

                height: mainRect.height/10
                color: "blue"
                font.bold: true
                font.pixelSize: height/3;
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            Label{
                text: qsTr("Steps: ") + logic.steps

                height: mainRect.height/10
                color: "blue"
                font.bold: true
                font.pixelSize: height/3;
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            Label{
                text: qsTr("Score: ") + logic.score

                height: mainRect.height/10
                color: "blue"
                font.bold: true
                font.pixelSize: height/3;
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Label{
            width: mainRect.width
            height: mainRect.height/10
            text: qsTr("You've got a great brain!")
            color: "blue"
            font.bold: true
            font.pixelSize: height/3;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Btn{
            width: mainRect.width/4*3;
            height: mainRect.height/7
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("Back to menu");
            fntSize: height/3;
            onClicked: {
                logic.restart();
                mainLoader.source = "MainMenu.qml"
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
