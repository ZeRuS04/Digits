import QtQuick 2.0

Rectangle {
    id: btn
    state: disable ? "Disable" : "Normal";
    border.color: "#845a00";
    property string text: "";
    property bool disable: false
    property color colorText: "black";
    property color colorText_2: "white";
    property int fntSize: width/3
    signal clicked();
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
                    color: "lightgreen";
                    border.width: 1;
                    radius: 5;
                }
                PropertyChanges {
                    target: buttonText
                    color: parent.colorText;
                }
        },
        State{
                name: "Disable"
                PropertyChanges {
                    target: btn;
                    color: "#6b6d6d";
                    border.width: 0;
                    radius: 0;
                }
                PropertyChanges {
                    target: buttonText
                    color: parent.colorText;
                }
        }

    ]
    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;

        onEntered: !btn.disable ? btn.state = "Pressed" : btn.state = "Disable"
        onExited: !btn.disable ? btn.state = "Normal" : btn.state = "Disable"
        onPressed: !btn.disable ? btn.state = "Pressed" : btn.state = "Disable"
        onClicked: {
            if(!btn.disable)
                btn.clicked();
        }
    }
}
