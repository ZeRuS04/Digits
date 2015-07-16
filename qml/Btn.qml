import QtQuick 2.0
import QtQuick 2.0

Rectangle {
    id: btn
    state: disable ? "Disable" : "Normal";
//    border.color: "#845a00";
    property string text: "";
    property bool disable: false
    property color colorText: "#3283ff";
    property color colorText_2: "white";
    property int duration: 500
    property string axis: "x"
    property int fntSize: 30
    signal clicked();
    border.width: 1
    border.color: "#3283ff"

    Cell{
        id: cell
        anchors.fill: parent
        upSideColor: "white"
        downSideColor: "white"
        downSidetextColor: "#3283ff"
        downSidetext: btn.text
        inputBordImageVisible: false
        borderImage: "qrc:/borderShadowBtn.png"
        axis: "x"
        onRotated: btn.clicked()
    }


    states: [
        State{
            name: "Normal"
            PropertyChanges {
                target: btn;
            }
            PropertyChanges {
                target: cell
                downSidetextColor: "#3283ff"
            }
        },
        State{
            name: "Pressed"
            PropertyChanges {
                target: btn;
            }
            PropertyChanges {
                target: cell
                downSidetextColor: "#white"
            }
        },
        State{
            name: "Highlighted"
            PropertyChanges {
                target: btn;
            }
            PropertyChanges {
                target: cell
                downSideColor: "#FFD283"
                downSidetextColor: "#3283ff"
            }
        },
        State{
            name: "Disable"
            PropertyChanges {
                target: btn;
            }
            PropertyChanges {
                target: cell
                downSideColor: "#4C79BF"
                downSidetextColor: "#white"
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
            if(!btn.disable){
                cell.rotate();
            }
        }
    }
}
