import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Rectangle {
    id: mainRect
    anchors.fill: parent
    color: "#fdf9f0";
    property var startNums: [1,1,1,2,1,3,1,4,1,5,1,6,1,7,1,8,1,9]
    property var pair: [];
    property int stepNumber: 0
    property var steps: [[],[1, 10], [8,17], [0, 2], [-1], [-2], [-3]]
    property var text: [
        "Grüsse Sie im Spiel DIGITS! \n
Es ist ein altes Puzzle, das sehr einfache Regeln hat. \n
Tippen hier für die Forzetzung.",
        "Sie müssen alle Zahlen reduzieren (in der klassischen Version). \n
Man kann gleiche Zahlen reduzieren, die in der Nähe finden sind. \n
Versuchen Sie.",
        "Auch kann man die Zahlen reduzieren, deren Summe gleich 10 ist. \n
Versuchen Sie.",
        "Wenn zwischen zwei Zahlen andere Zahlen fehlen, können Sie diese Zahlen reduzieren, obwohl sie nicht in der Nähe sind. \n
Versuchen Sie.",
        "Wenn die Reduzierungsoptionen fehlen (oder Sie wollen nicht reduzieren),\n
können Sie tippen \"Next step\".\n
Versuchen Sie.",
        "Wenn Sie eine Fehler machen, können Sie seine letzte Wirkung abschaffen.\n
Für die Abschaffung tippen \"Undo\".\n
Versuchen Sie.",
        "Wenn Sie neues Spiel beginnen wollen, tippen \"Restart\".\n
Wenn Sie ins Menu gehen wollen, tippen \"Menu\".",
        ""
    ]
    property var cells: []

    function nextStep(){
        if(stepNumber >= steps.length){
            /*
              END guide
              */
            mainLoader.source = "GameModesMenu.qml"
        }else{
            if(steps[mainRect.stepNumber][0] < 0){
                if(steps[mainRect.stepNumber][0] === -1)
                    nsBlock.visible = false;
                if(steps[mainRect.stepNumber][0] === -2)
                    undoBlock.visible = false;
                if(steps[mainRect.stepNumber][0] === -3)
                    restartBlock.visible = false;
            }else{
                for(var i = 0; i < steps[mainRect.stepNumber].length; i++){
                    cells[steps[mainRect.stepNumber][i]].block = false;
                    cells[steps[mainRect.stepNumber][i]].maVis = true;
                }
            }
        }
    }

    Rectangle{

        id: statRow
//        anchors.top: parent.top
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

    Rectangle{
        anchors.fill: parent
        color: Qt.rgba(0,0,0,0.5);
        MouseArea{
            anchors.fill: parent
            onClicked: {}
            hoverEnabled: true
            onEntered: {}
        }
        Rectangle{
            id: gridField
            anchors{
//                fill: parent
                top: statRow2.bottom
                right: parent.right
                left: parent.left
                bottom: btnRow.top
            }
//            flickableDirection: Flickable.VerticalFlick

            color: Qt.rgba(0,0,0,0.0);
            Grid{
                id: grid
                columns: 9
                spacing: mainRect.width/10/9
                Repeater{
                    id: rep
                    model: startNums.length

                    delegate: Cell{
                        id: rect
                        width: mainRect.width/10
                        height: mainRect.width/10
                        property int row: index/9
                        property int column: index%9
                        property int i: index
                        property bool maVis: false
                        property bool block: true
                        state: n != 0 ? "Delete" : "Default"

                        n: mainRect.startNums[index];

                        Rectangle{
                            id: cellBlock
                            anchors.fill: parent
                            radius: parent.radius
                            visible: parent.block
                            color: Qt.rgba(0,0,0,0.5);

                        }
                        MouseArea{
                            id: cellMA
                            anchors.fill: parent
                            hoverEnabled:rect.state == "Delete" ? true : false
                            onEntered: parent.border.width = 2
                            onExited: parent.border.width = 1
                            visible: rect.maVis
                            onClicked:{
                                if((rect.state == "Default") || (rect.state == "Check")){
                                    if(pair.length == 1){
                                        if(rect == pair[0]){
                                            rect.state = "Default";
                                            pair.length = 0;
                                        }else{
                                            startNums[pair[0].i] = 0;
                                            pair[0].state = "Delete"
                                            pair[0].block = true;
                                            startNums[rect.i] = 0;
                                            rect.state = "Delete";
                                            rect.block = true;
                                            pair.length = 0;
                                            stepNumber++;
                                            nextStep();
                                        }
                                    }else
                                    {
                                        rect.state = "Check";
                                        pair.push( rect );
                                    }
    //                                settings.setValue("NumArray", mainRect.nums);
                                }
                            }
                        }


                        Component.onCompleted: {
                            mainRect.cells.push(rect);
                            if((index == 1) || (index == 10))
                            {
                                rect.maVis = true
                            }
                            if(n === 0)
                                state = "Delete"
                        }
                    }
                    Component.onCompleted: {
                        mainRect.nextStep()
                    }
                }
            }


        }
        Label{
            anchors.bottom: btnRow.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height/4
            text: mainRect.text[stepNumber]
            color: "#fdf9f0"
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            font.pointSize: 72
            fontSizeMode: Text.Fit;
            font.family: "Arial"
            font.bold: true
            wrapMode: Text.WordWrap;
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    if(mainRect.steps[mainRect.stepNumber].length === 0){
                        mainRect.stepNumber++;
                        nextStep();
                    }
                }
            }

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
                    id: menu
                    width: height
                    Layout.fillHeight: true
                    text: "Menu"
                    onClicked: mainLoader.source = "MainMenu.qml"
                }
            }
            Button{
                anchors.right: statRow2.right
                anchors.top: statRow2.top
                id: restart
                width: menu.width
                height: menu.height
                text: "Restart"
                onClicked: {
                    logic.restart();
                    mainLoader.source = "Game.qml"
                }

                Rectangle{
                    id: restartBlock
                    anchors.fill: parent
                    visible: parent.block
                    color: Qt.rgba(0,0,0,0.5);
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {}
                    }
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
                onClicked: {
                    startNums.length = 0;
                    startNums.push(0,0,0,2,1,3,1,4,0,5,0,6,1,7,1,8,1,0);
                    cells.length = 0;
                    rep.model = startNums.length;
                    stepNumber++;
                    nextStep();
                    undoBlock.visible = true
                }

                Rectangle{
                    id: undoBlock
                    anchors.fill: parent
                    visible: parent.block
                    color: Qt.rgba(0,0,0,0.5);
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {}
                    }
                }
            }
            Button{
                id: nextStepButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "Next step"
                property bool isActive: true
                onClicked:{
                    mainRect.startNums.push(2,1,3,1,4,5,6,1,7,1,8);
                    cells.length = 0;
                    rep.model = startNums.length;
                    stepNumber++;
                    nextStep();

                    nsBlock.visible = true;

                }
                Rectangle{
                    id: nsBlock
                    anchors.fill: parent
                    visible: parent.block
                    color: Qt.rgba(0,0,0,0.5);
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {}
                    }
                }

            }
        }

    }

}
