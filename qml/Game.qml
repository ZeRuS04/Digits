import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Rectangle {
    id: mainRect
    anchors.fill: parent
    color: "#3283ff";
    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation
    property int score_constant:10
    property var pair: [];

    Timer{
        interval: 1000; running: true; repeat: true
        onTriggered:{
            logic.time++;
        }
    }

    GridView{
        id: grid
        anchors.topMargin:  mainRect.width/10/11+5
        anchors.leftMargin: mainRect.width/10/11
        anchors{
//            fill: parent
            top: statRow.bottom
            right: parent.right
            left: parent.left
            bottom: btnRow.top
        }
        cellHeight: mainRect.width/10+mainRect.width/10/12
        cellWidth: mainRect.width/10+mainRect.width/10/12
        property var prevRatio: 0
        delegate: Cell{
            id: rect
            width: mainRect.width/10
            height: mainRect.width/10
            upSideColor: "#3283ff"
            downSideColor: "white"
            checkColor: "#FFB100"
            checktextColor: "black"
            downSidetextColor: "black"
//            downSidetextColor: "#3283ff"
            property int row: index/9
            property int column: index%9
            property int i: index
            state: n == 0 ? "UpSide" : "DownSide"
            n: modelData[index]
            downSidetext: n
            Connections{
                target: logic
                onNumsChanged: {
                    rect.n = logic.getNum(index);
                    rect.state = (n == 0 ? "UpSide" : "DownSide")
                }
                onHaveSolution: {
                    if((rect.i === pos1) || (rect.i === pos2)){
                        cellTimer.prevState = rect.state;
                        cellTimer.start()
                        rect.state = "Highlighted";
                    }
                }

            }

            Timer{
                id: cellTimer
                interval: 1500
                repeat: false
                running: false
                property var prevState: "DownSide"
                onTriggered: rect.state = prevState
            }

            MouseArea{
                anchors.fill: parent
//                hoverEnabled: true
                onEntered: parent.pressed = true
                onExited: parent.pressed = false
                onClicked:{
                    if((rect.state == "DownSide") /*|| (rect.state == "Check")*/){
                        if(logic.state == 1){
                                if(logic.checkPair(pair[0].i, rect.i)){
                                    logic.numToNull(pair[0].i);
                                    logic.numToNull(rect.i)
                                    logic.saveNumsList();
                                    pair[0].unselectCell();
                                    pair[0].rotate(false)
                                    rect.rotate(false);
                                    cellTimer.prevState = rect.state;
                                    mainRect.pair.length = 0;
                                    logic.state = 0;
                                    logic.score += mainRect.score_constant;
                                }else{
                                    rect.unselectCell();
                                    pair[0].unselectCell();
                                    cellTimer.prevState = rect.state;
                                    mainRect.pair.length = 0;
                                    logic.state = 0;
                                }
                        }else
                        {
                            rect.selectCell();
                            cellTimer.prevState = rect.state;
                            logic.checkCell(rect.i);
                            pair.push( rect );
                        }
                    }
                }
            }

        }
        model: logic.nums
        onModelChanged: {
            contentY = prevRatio;
        }

        Connections{
            target: logic
            onHaveSolution: {
                grid.positionViewAtIndex(pos1, GridView.Center);
            }
        }


    }
    ScrollBar {
        id: gridScrollBar
        height: grid.height;
        width:  8
        scrollArea: grid;
        anchors.top: grid.top
        anchors.right: grid.right
    }


    Rectangle{

        id: statRow
        anchors.top: parent.top
        width: parent.width
        height: mainRect.height/10
        color: mainRect.color

        ImgButton{
            id: mainMenu
            anchors.top: parent.top; anchors.left: parent.left;
            width: height;  height: parent.height
            imgName: "ic_menu_white_24dp"
            onClicked: {
                mainLoader.source = "MainMenu.qml"
            }
        }
        RowLayout{
            anchors.left: mainMenu.right
            anchors.right: restartButton.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
//            anchors.margins: 7

            ColumnLayout{

                Layout.fillWidth: true
                Layout.fillHeight: true
                Label{
                    id: scoreLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: robotoRegular.name
                    fontSizeMode: Text.Fit;
//                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    text: qsTr("Score: ") + logic.score
                }
                Label{
                    id: stepsLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit;
                    font.family: robotoRegular.name
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    text: qsTr("Steps: ") + logic.steps
                }

            }
            ColumnLayout{

                Layout.fillWidth: true
                Layout.fillHeight: true
                Label{
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit;
                    font.family: robotoRegular.name
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    text: qsTr("Time")
                }
                Label{
                    id: timeLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit;
                    font.family: robotoRegular.name
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    text: logic.secToString(logic.time)
                }
            }

        }
        ImgButton{
            id: restartButton
            anchors.top: parent.top; anchors.right: parent.right;
            width: height;  height: parent.height
            imgName: "ic_refresh_white_24dp"
            onClicked: {
                logic.restart()
                grid.positionViewAtBeginning();
            }
        }



    }
    Image {
        id: topLine
        width: parent.width; height: 15
        anchors.verticalCenter: statRow.bottom
        anchors.left: parent.left
        source: "qrc:/res/line_shadow.png"
    }
    Image {
        id: bottomLine
        width: parent.width; height: 15
        anchors.verticalCenter: btnRow.top
        anchors.left: parent.left
        source: "qrc:/res/line_shadow.png"
    }
    Rectangle{
        id: btnRow
        anchors.bottom: parent.bottom
        anchors.margins: 7
        width: parent.width
        height: mainRect.height/10
        color: parent.color
        ImgButton{
            id: undoButton
            anchors.top: parent.top; anchors.left: parent.left;
            width: height;  height: parent.height
            imgName: "ic_undo_white_24dp"
            onClicked: logic.undo();


        }
        ImgButton{
            id: checkSolution
            anchors.centerIn: parent
            height: btnRow.height
            width: height
            imgName: "ic_wb_incandescent_white_24dp"
            onClicked:{
                if(checkSolution.state == "Default"){
                    logic.checkSolution();
                }
            }
            Connections{
                target: logic
                onHaveNotSolution: {
                    checkSolution.state = "Red"
                    solTimer.start();

                }
                onHaveSolution: {
                    checkSolution.state = "Green"
                    logic.score -= 5
                    solTimer.start();
                }
            }
            Timer{
                id: solTimer
                interval: 1500
                repeat: false
                running: false
                onTriggered: checkSolution.state = "Default"
            }
        }
        ImgButton{
            id: nextStepButton
            anchors.top: parent.top; anchors.right: parent.right;
            width: height;  height: parent.height
            property bool isActive: true
            imgName: "ic_redo_white_24dp"
            onClicked:{
                if(isActive){

                    isActive = false;
                    timer.start();
                    grid.prevRatio = grid.contentY;
                    logic.nextStep();
                }
            }
            Timer{
                id: timer
                interval: 500
                repeat: false
                running: false
                onTriggered: parent.isActive = true
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
