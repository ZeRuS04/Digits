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
    property var steps: [[],[1, 10], [8,17], [0, 2]]
    property var text: [
        "Приветствую вас в игре DIGITS! \n
Это старая советская головоломка. Её правила очень просты. \n
Коснись здесь что бы продолжить",
        "Вы должны сократить все цифры(в классическом варианте). \n
Сокращать можно одинаковые цифры стоящие рядом. \n
Попробуйте.",
        "Так же можно сокращать цифры, которые в сумме дают 10. \n
Попробуйте.",
        "Кроме того, если цифры не рядом, но между ними нет других цифр их тоже можно сократить. \n
Попробуйте."
    ]
    property var cells: []

    function nextStep(){
        if(stepNumber >= steps.length){
            /*
              END guide
              */
            mainLoader.source = "GameModesMenu.qml"
        }else{
            for(var i = 0; i < steps[mainRect.stepNumber].length; i++){
                cells[steps[mainRect.stepNumber][i]].block = false;
                cells[steps[mainRect.stepNumber][i]].maVis = true;
            }
        }
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
                    model: 18

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

                        Connections{
                            target: logic
                            onNumsChanged: {
                                rect.n = logic.getNum(index);
                                rect.state = (n == 0 ? "Delete" : "Default")
                            }
                        }
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
                                            pair[0].state = "Delete"
                                            rect.state = "Delete";
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
                    id: mainMenu2
                    width: height
                    Layout.fillHeight: true
                    text: "Menu"
                    onClicked: mainLoader.source = "MainMenu.qml"
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
//                onClicked: logic.undo();


            }
            Button{
                id: nextStepButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "Next step"
                property bool isActive: true
                onClicked:{
//                    if(isActive){
//                        isActive = false;
//                        timer.start();
//                        logic.nextStep();
//                    }
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

}
