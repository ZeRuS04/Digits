import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Rectangle {
    id: mainRect
    anchors.fill: parent
    color: "#fdf9f0";
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
        anchors.margins: mainRect.width/10/11
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
            property int row: index/9
            property int column: index%9
            property int i: index
            state: n == 0 ? "Delete" : "Default"
            n: logic.getNum(index);
            Connections{
                target: logic
                onNumsChanged: {
                    rect.n = logic.getNum(index);
                    rect.state = (n == 0 ? "Delete" : "Default")
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
                property var prevState: "Default"
                onTriggered: rect.state = prevState
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.border.width = 2
                onExited: parent.border.width = 1
                onClicked:{
                    if((rect.state == "Default") || (rect.state == "Check")){
                        if(logic.state == 1){
                                if(logic.checkPair(pair[0].i, rect.i)){
                                    logic.numToNull(pair[0].i);
                                    logic.numToNull(rect.i)
                                    logic.saveNumsList();
                                    pair[0].state = "Delete"
                                    rect.state = "Delete";
                                    cellTimer.prevState = rect.state;
                                    mainRect.pair.length = 0;
                                    logic.state = 0;
                                    logic.score += mainRect.score_constant;
//                                            settings.setValue("Score", mainRect.score);

                                }else{
                                    pair[0].state = "Default";
                                    rect.state = "Default";
                                    cellTimer.prevState = rect.state;
                                    mainRect.pair.length = 0;
                                    logic.state = 0;
                                }
                        }else
                        {
                            rect.state = "Check";
                            cellTimer.prevState = rect.state;
                            logic.checkCell(rect.i);
                            pair.push( rect );
                        }
//                                settings.setValue("NumArray", mainRect.nums);
                    }
                }
            }
        }
        model: logic.numsCount
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
//        orientation: isPortrait ? Qt.Horizontal : Qt.Vertical
        height: /*isPortrait ? 8 : */grid.height;
        width: /*isPortrait ? grid.width :*/ 8
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
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#fdefd0";
            }
            GradientStop {
                position: 0.57;
                color: "#fdf9f0";
            }
        }

        RowLayout{
            anchors.fill: parent
            anchors.margins: 7
            GButton{
                id: mainMenu
                width: height
                Layout.fillHeight: true
                text: qsTr("Menu")
                onClicked: {
                    mainLoader.source = "MainMenu.qml"
                }
            }
            ColumnLayout{

                Layout.fillWidth: true
                Layout.fillHeight: true
                Label{
                    id: scoreLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit;
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("Score: ") + logic.score
                }
                Label{
                    id: stepsLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit;
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
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
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("Time")
                }
                Label{
                    id: timeLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit;
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: logic.secToString(logic.time)
                }
            }
            GButton{
                id: restartButton
                anchors.margins: 10
                width: height
                Layout.fillHeight: true
                text: qsTr("Restart")
                onClicked: {
                    logic.restart()
                    grid.positionViewAtBeginning();
                }
            }
        }


    }

    RowLayout{
        id: btnRow
        anchors.bottom: parent.bottom
        anchors.margins: 7
        width: parent.width
        height: mainRect.height/10
        GButton{
            id: undoButton
            anchors.margins: 7
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Undo")
            onClicked: logic.undo();


        }
        GButton{
            id: checkSolution
            anchors.margins: 7
//            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("?")
            onClicked:{
                logic.checkSolution();
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
        GButton{
            id: nextStepButton
            anchors.margins: 7
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Next step")
            property bool isActive: true
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
