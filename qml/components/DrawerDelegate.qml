import QtQuick 2.0
import Felgo 3.0

Item {
    signal clicked()

    property alias text: appText.text
    property alias icon: icon.icon

    id: root
    height: dp(69)

    Icon {
        id: icon
        anchors {
            leftMargin: root.width * 0.1
            left: root.left
            verticalCenter: root.verticalCenter
        }
        icon: IconType.times
    }

    AppText {
        id: appText
        anchors {
            leftMargin: root.width * 0.2
            left: icon.left
            verticalCenter: root.verticalCenter
        }
        text: "Button"
    }

    RippleMouseArea {
        anchors.fill: parent
        circularBackground: false

        onClicked: root.clicked()
    }

    Rectangle {
        anchors.bottom: root.bottom
        height: dp(0.5)
        color: Theme.dividerColor
        width: root.width
    }
}
