import QtQuick.Controls 2.12
import Felgo 3.0
import QtQuick 2.0

import "../style"
import "../components"

Page {
    property alias model: listView.model

    id: root
    title: qsTr("Todo List")

    onAppeared: Theme.colors.tintColor = Style.todoListPageColor

    onPushed: pushAnim.start()

    leftBarItem: IconButtonBarItem {
        icon: IconType.bars

        onClicked: drawer.toggle()
    }

    rightBarItem: ActivityIndicatorBarItem {
        enabled: false/*dataModel.isBusy*/
        visible: enabled
        showItem: showItemAlways
    }

    AppListView {
        id: listView
        anchors.fill: parent

        delegate: SwipeOptionsContainer {
            id: optionsContainer

            leftOption: SwipeOptionButton {
                height: simpleRow.height
                color: Style.editColor
                icon: IconType.pencil

                onClicked: {
                    InputDialog.inputTextSingleLine(app, "Edit todo title:",
                                                    simpleRow.text,
                                                    function (ok, text) {
                                                        if (ok)
                                                            logic.editTodo(index, text)
                                                    })
                    optionsContainer.hideOptions()
                }
            }

            rightOption: SwipeOptionButton {
                height: simpleRow.height
                color: Style.deleteColor
                icon: IconType.trash

                onClicked: {
                    console.log("index: " + index)
                    logic.deleteTodo(index)
                }
            }

            SimpleRow {
                id: simpleRow
                text: title
                detailText: "Created by " + createdBy

                Item {
                    anchors {
                        top: parent.top
                        right: parent.right
                        bottom: parent.bottom
                    }
                    width: height

                    AppCheckBox {
                        id: checkBox
                        anchors.centerIn: parent
                        checked: isDone

                        onCheckedChanged:  {
                            if (checked)
                                logic.markCompleted(index)
                            else
                                logic.markNotCompleted(index)
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        width: dp(55)
        height: width
        radius: width / 2
        anchors {
            right: parent.right
            rightMargin: dp(20)
            bottom: parent.bottom
            bottomMargin: dp(20)
        }
        color: Theme.tintColor

        IconButton {
            anchors.centerIn: parent
            icon: IconType.plus
            color: Theme.secondaryBackgroundColor
            size: sp(23)

            onClicked:
                InputDialog.inputTextSingleLine(app, "Enter todo title:", "",
                                                function (ok, text) {
                                                    if (ok)
                                                        logic.storeTodo(text)
                                                })
        }
    }

    AppDrawer {
        id: drawer

        Rectangle {
            anchors.fill: parent
            color: Theme.backgroundColor
        }

        DrawerDelegate {
            text: qsTr("Sign Out")
            icon: IconType.signout
            width: parent.width

            onClicked: logic.signout()
        }
    }

    MouseArea {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: drawer.right
            right: parent.right
        }
        enabled: drawer.isOpen

        onClicked: drawer.close()
    }

    ParallelAnimation {
        id: pushAnim

        NumberAnimation {
            target: root
            property: "opacity"
            duration: 500
            from: 0
            to: 1
        }

        NumberAnimation {
            target: root
            property: "y"
            duration: 500
            from: root.height
            to: navStack.navigationBar.height
            easing.type: Easing.OutQuad
        }
    }
}
