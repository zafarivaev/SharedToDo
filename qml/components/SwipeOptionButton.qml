import QtQuick 2.0
import Felgo 3.0

Rectangle {
    signal clicked()

    property alias icon: icon.text

    id: root
    height: Theme.appButton.minimumHeight
    width: dp(120)
    color: Theme.tintColor

    AppText {
        id: icon
        anchors.centerIn: parent
        text: IconType.times
        color: Theme.secondaryBackgroundColor
        font.pixelSize: sp(27)
    }

    RippleMouseArea {
        anchors.fill: parent
        circularBackground: false

        onClicked: root.clicked()
    }
}
