import QtQuick.Controls 2.12
import Felgo 3.0
import QtQuick 2.0

import "../style"
import "../components"

Page {
    property alias model: listView.model

    id: root
    title: qsTr("Todo List")

    onAppeared: {
        Theme.colors.tintColor = Style.todoListPageColor
        Theme.navigationBar.backgroundColor = Style.todoListPageColor
    }

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

        delegate: SimpleRow {
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
                    anchors.centerIn: parent
                    checked: isDone
                }
            }
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

    //    Column {
    //        anchors.centerIn: parent
    //        AppButton {
    //            text: "Store"
    //            onClicked: logic.storeTodo("test todo")
    //        }

    //        AppButton {
    //            text: "Fetch"
    //            onClicked: logic.fetchTodos()
    //        }
    //    }
}
