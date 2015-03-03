import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: mainRect
    anchors.fill: parent
    color: "#fdf9f0";
    property int score_constant:10
    property var pair: [];




    Timer{
        interval: 1000; running: true; repeat: true
        onTriggered:{
            logic.time++;
//            settings.setValue("Time", mainRect.time);
        }
    }

    Flickable{

        anchors{
//            fill: parent
            top: statRow.bottom
            right: parent.right
            left: parent.left
            bottom: btnRow.top
        }
        flickableDirection: Flickable.VerticalFlick

        Grid{
            id: grid
            columns: 9
            spacing: mainRect.width/10/9
            Repeater{
                id: rep
                model: logic.numsCount

                delegate: Cell{
                    id: rect
                    width: mainRect.width/10
                    height: mainRect.width/10
                    property int row: index/9
                    property int column: index%9
                    property int i: index
                    state: n == 0 ? "Delete" : "Default"
//                    property bool vis: modelData == 0 ? false : true;
                    n: logic.getNum(index);

                    Connections{
                        target: logic
                        onNumsChanged: {
                            rect.n = logic.getNum(index);
                            rect.state = (n == 0 ? "Delete" : "Default")
                        }
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
                                            mainRect.pair.length = 0;
                                            logic.state = 0;
                                            logic.score += mainRect.score_constant;
//                                            settings.setValue("Score", mainRect.score);

                                        }else{
                                            pair[0].state = "Default";
                                            rect.state = "Default";
                                            mainRect.pair.length = 0;
                                            logic.state = 0;
                                        }
                                }else
                                {
                                    rect.state = "Check";
                                    logic.checkCell(rect.i);
                                    pair.push( rect );
                                }
//                                settings.setValue("NumArray", mainRect.nums);
                            }
                        }
                    }
                }
            }
        }
        contentHeight: grid.height
        contentWidth: grid.width
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
            Button{
                anchors.margins: 10
                id: mainMenu
                width: height
                Layout.fillHeight: true
                text: "Menu"
                onClicked: mainLoader.source = "MainMenu.qml"
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
                    text: "Score: " + logic.score
                }
                Label{
                    id: stepsLabel
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit;
                    font.bold: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: "Steps: " + logic.steps
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
                    text: "Time"
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
            Button{
                id: restartButton
                anchors.margins: 10
                width: height
                Layout.fillHeight: true
                text: "Restart"
                onClicked: logic.restart()
            }
        }


    }

    RowLayout{
        id: btnRow
        anchors.bottom: parent.bottom
        width: parent.width
        height: mainRect.height/10
        Button{
            id: undoButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Undo"
//            visible: mainRect.backupNums.length
//            checkable: backupNums.length == 0 ? false : true
            onClicked: logic.undo();
//                if(mainRect.backupNums.length !== 0){
//                    mainRect.nums = mainRect.backupNums.slice(0);
//                    mainRect.backupNums.length = 0;
//                    rep.model = 0;
//                    mainRect.score -= 10;
//                    rep.model = mainRect.nums;
//                }


        }
        Button{
            id: nextStepButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Next step"
            property bool isActive: true
            onClicked:{
                if(isActive){
                    isActive = false;
                    timer.start();
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
}
