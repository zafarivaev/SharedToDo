import QtQuick 2.12
import Felgo 3.0
import QtQuick.Controls 2.12

Item {
    signal checkChanged()
    signal deleted()

    property alias titleText: textTitle.text
    property string detailText: ""
    property alias isChecked: checkBox.checked

    id: root
    anchors {
        left: parent.left
        right: parent.right
    }
    height: column.childrenRect.height + _.verticalMargins * 2

    ListView.onRemove: SequentialAnimation {
        PropertyAction {
            target: root
            property: "ListView.delayRemove"
            value: true
        }
        NumberAnimation {
            target: root
            property: "height"
            to: 0
            easing.type: Easing.InOutQuad
        }
        PropertyAction {
            target: root
            property: "ListView.delayRemove"
            value: false
        }
    }

    // private properties
    Item {
        id: _

        property int verticalMargins: dp(15)
        property int horizontalMargins: dp(25)
        property int checkBoxHorizontalMargins: horizontalMargins
    }

    Rectangle {
        anchors.fill: parent
        color: "tomato"
        visible: item.x !== 0
        enabled: visible

        Icon {
            anchors.verticalCenter: parent.verticalCenter
            icon: IconType.trash
            color: Theme.backgroundColor
            x: item.x > 0 ? _.horizontalMargins
                          : parent.width - width - _.horizontalMargins
        }
    }

    Item {
        id: item
        height: root.height
        width: root.width

        Rectangle {
            anchors.fill: parent
            color: Theme.backgroundColor
        }

        Column {
            id: column
            anchors {
                left: item.left
                leftMargin: _.verticalMargins
                right: checkBox.left
                rightMargin: _.checkBoxHorizontalMargins
                verticalCenter: item.verticalCenter
            }

            AppText {
                id: textTitle
                width: parent.width
                color: Theme.listItem.textColor
                font.pixelSize: sp(Theme.listItem.fontSizeText)
                wrapMode: Text.WordWrap
            }

            AppText {
                id: textDetail
                text: "Created by " + detailText
                color: Theme.listItem.detailTextColor
                font.pixelSize: sp(Theme.listItem.fontSizeDetailText)
            }
        }

        AppCheckBox {
            id: checkBox
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: _.checkBoxHorizontalMargins
            }

            onCheckedChanged: checkChanged()
        }

        Rectangle {
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            height: 1
            color: Theme.dividerColor
        }

        RippleMouseArea {
            anchors.fill: parent
            circularBackground: false
            drag {
                target: item
                axis: Drag.XAxis
            }

            onClicked: isChecked = !isChecked
            onPressAndHold: nativeUtils.displayTextInput("Edit to-do text:", "")
            onReleased: {
                if (Math.abs(item.x) < item.width / 2) {
                    animBack.start()
                }
                else {
                    animDelete.to = item.x < 0 ? -item.width : item.width
                    animDelete.start()
                }
            }
        }

        NumberAnimation {
            id: animBack
            target: item
            property: "x"
            to: 0
            duration: 150
            easing.type: Easing.OutQuad
        }

        NumberAnimation {
            id: animDelete
            target: item
            property: "x"
            duration: 100
            easing.type: Easing.OutQuad

            onFinished: if (item.x !== 0) {
                            root.deleted()
                        }
        }
    }
}
