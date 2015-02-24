import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: mainRect
    anchors.fill: parent

    property int score_constant:10
    property var pair: [];

    function integerDivision(x, y){
        return (x-x%y)/y
    }

    function secToString(time) {
        var seconds = time%60;
        if(seconds < 10)
            seconds = "0" + String(seconds)
        else
            seconds = String(seconds)
        time = integerDivision(time,60);
        var minutes = time%60;
        if(minutes < 10)
            minutes = "0" + String(minutes)
        else
            minutes = String(minutes)
        time = integerDivision(time,60);
        var hours = time%24;
        var days = integerDivision(time,24);
        var string = "";
        if (days!=0) {
                string = days +":"+ hours +":"+  minutes +":"+ seconds;
        } else if (hours!=0) {
                string = hours +":"+ minutes +":"+ seconds;
        } else {
                string = minutes +":"+ seconds;
        }
        return string;
    }

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
                Connections{
                    target: mainRect
                    onUpdated: {
                        rep.model = mainRect.nums;
                    }
                }

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
        RowLayout{
            anchors.fill: parent
            Label{
                id: scoreLabel
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "Score: " + logic.score

    //            font.pixelSize:
            }
            Label{
                id: timeLabel
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "Time: "+ mainRect.secToString(logic.time)

//                font.pixelSize: score.height/2
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
            id: restartButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Restart"
            onClicked: logic.restart()
//                mainRect.nums = [1,1,1,2,1,3,1,4,1,5,1,6,1,7,1,8,1,9];
//                settings.setValue("NumArray", mainRect.nums);
//                rep.model = 0;
//                rep.model = mainRect.nums;
//                mainRect.score = 0;
//                settings.setValue("Score", mainRect.score);
//                mainRect.time = 0
//                settings.setValue("Time", mainRect.time);
//                mainRect.backupNums.length = 0;


        }
        Button{
            id: nextStepButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Next step"
            onClicked: logic.nextStep()
        }
    }
}
