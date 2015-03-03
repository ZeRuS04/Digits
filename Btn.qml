import QtQuick 2.0

Rectangle {
    id: btn
    state: "Normal";
    border.color: "#845a00";
    property string text: "";

    property color colorText: "black";
    property color colorText_2: "white";
    property int fntSize: 30

    Text{
        id: buttonText
        anchors.fill: parent;
        text: parent.text;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        font.pixelSize: parent.fntSize;
        font.family: "Arial"
        font.bold: true
        wrapMode: Text.WordWrap;
    }

    states: [
        State{
            name: "Normal"
            PropertyChanges {
                target: btn;
                color: "skyblue"
                border.width: 1;
                radius: 5;
            }
            PropertyChanges {
                target: buttonText
                color: parent.colorText;
            }
        },
        State{
                name: "Pressed"
                PropertyChanges {
                    target: btn;
                    color: "#6b6d6d";
                    border.width: 0;
                    radius: 0;
                }
                PropertyChanges {
                    target: buttonText
                    color: parent.colorText_2;
                }
        }

    ]
    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;

        onEntered: btn.state = "Pressed"
        onExited: btn.state = "Normal"
        onPressed: btn.state = "Pressed"
    }
}
