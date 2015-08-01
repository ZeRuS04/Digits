import QtQuick 2.0

Rectangle {
    id:about
    color: "white";
    FontLoader {
        id: robotoRegular
        source: "qrc:/res/Roboto-Regular.ttf"
    }
    FontLoader {
        id: robotoItalic
        source: "qrc:/res/Roboto-LightItalic.ttf"
    }
    Column{
        id: optColumn
        spacing: 50
        anchors.fill: parent
        anchors.margins: parent.height < parent.width ? parent.height/10 : parent.width/10
        Text{
            id: title
            text: qsTr("ABOUT");
            width: parent.width
            horizontalAlignment: Text.AlignHCenter;
            font.pixelSize: 30;
            font.family: robotoRegular.name
//            font.bold: true
            wrapMode: Text.WordWrap;
        }
        Text{
            id: version
            text: logic.appName() + " " + logic.appVersion();
            width: parent.width
            horizontalAlignment: Text.AlignHCenter;
            font.pixelSize: 18;
            font.family: robotoItalic.name
            font.bold: true
            wrapMode: Text.WordWrap;
        }
        Text{
            id: author
            text: qsTr("Author: \t") + logic.appAuthor();
            width: parent.width
//            horizontalAlignment: Text.AlignHCenter;
            font.pixelSize: 18;
            font.family: robotoItalic.name
            font.bold: true
            wrapMode: Text.WordWrap;
        }
        Text{
            id: mail
            text: qsTr("Mail: \t") + logic.appMail();
            width: parent.width
//            horizontalAlignment: Text.AlignHCenter;
            font.pixelSize: 18;
            font.family: robotoItalic.name
            font.bold: true
            wrapMode: Text.WordWrap;
        }
        Text{
            id: specialThx
            text: qsTr("Special thanks to:\n Sinelshchikova Ekaterina, Shishkin Michael")
            width: parent.width
            horizontalAlignment: Text.AlignHCenter;
            font.pixelSize: 18;
            font.family: robotoItalic.name
            font.bold: true
            wrapMode: Text.WordWrap;
        }
        Btn{
            id: back
            width: parent.width;
            height: parent.height/8
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("BACK");
            fntSize: height/3;
            onClicked: {
                mainFlickable.contentX+=about.width
            }
        }
    }

    focus: true
    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {

//            mainLoader.source = "MainMenu.qml"
            event.accepted = true
        }
    }
    Component.onCompleted: {
        forceActiveFocus();
    }

}
