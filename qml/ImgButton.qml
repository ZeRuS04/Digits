import QtQuick 2.0

Item {
    id: mainRect
    property string imgName: "";
    property string imgNamewithShadow: imgName + "_shd"
    signal clicked();
    Image {
        id: img
        anchors.fill: parent
        source: "qrc:/res/" + imgNamewithShadow + ".png"
    }
    MouseArea{
        anchors.fill: parent
        onClicked: mainRect.clicked();
        onPressed: img.source = "qrc:/res/" + imgName + ".png"
        onReleased: img.source = "qrc:/res/" + imgNamewithShadow + ".png"
    }
    Component.onCompleted: console.log(img.source)
}

