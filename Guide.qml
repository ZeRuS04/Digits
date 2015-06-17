import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: mainRect
    anchors.fill: parent
    color: "#fdf9f0";
    property int score_constant:10
    property var pair: [];

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
            onClicked: logic.undo();


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

    Rectangle{
        anchors.fill: parent
        color: Qt.rgba(0,0,0,0.5);
        MouseArea{
            anchors.fill: parent
            onClicked: {}
            hoverEnabled: true
            onEntered: {}
        }
        Flickable{

            anchors{
    //            fill: parent
                top: statRow2.bottom
                right: parent.right
                left: parent.left
                bottom: btnRow.top
            }
            flickableDirection: Flickable.VerticalFlick

            Grid{
                id: grid2
                columns: 9
                spacing: mainRect.width/10/9
                Repeater{
                    id: rep2
                    model: logic.numsCount

                    delegate: Cell{
                        id: rect2
                        width: mainRect.width/10
                        height: mainRect.width/10
                        property int row: index/9
                        property int column: index%9
                        property int i: index
                        state: n == 0 ? "Delete" : "Default"

//                        color: {
//                            if((index == 1) || (index == 10))
//                                Qt.rgba(0,0,0,0);
//                        }
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
                                if((rect2.state == "Default") || (rect2.state == "Check")){
                                    if(logic.state == 1){
                                            if(logic.checkPair(pair[0].i, rect2.i)){
                                                logic.numToNull(pair[0].i);
                                                logic.numToNull(rect2.i)
                                                logic.saveNumsList();
                                                pair[0].state = "Delete"
                                                rect2.state = "Delete";
                                                mainRect.pair.length = 0;
                                                logic.state = 0;
                                                logic.score += mainRect.score_constant;
    //                                            settings.setValue("Score", mainRect.score);

                                            }else{
                                                pair[0].state = "Default";
                                                rect2.state = "Default";
                                                mainRect.pair.length = 0;
                                                logic.state = 0;
                                            }
                                    }else
                                    {
                                        rect2.state = "Check";
                                        logic.checkCell(rect2.i);
                                        pair.push( rect2 );
                                    }
    //                                settings.setValue("NumArray", mainRect.nums);
                                }
                            }
                        }
                        Component.onCompleted: {
                            if((index == 1) || (index == 10))
                                color = Qt.rgba(0,0,0,0);
                        }
                    }
                }
            }
            contentHeight: grid.height
            contentWidth: grid.width
        }

        Rectangle{

            id: statRow2
            anchors.top: parent.top
            width: parent.width
            height: mainRect.height/10
            color: Qt.rgba(0,0,0,0);


            RowLayout{
                anchors.fill: parent
                Button{
                    anchors.margins: 10
                    id: mainMenu2
                    width: height
                    Layout.fillHeight: true
                    text: "Menu"
                    onClicked: mainLoader.source = "MainMenu.qml"
                }

            }


        }

    }
}
