import QtQuick.Controls 2.12
import Felgo 3.0
import QtQuick 2.0

import "../style"
import "../components"

Page {
    id: root
    title: qsTr("Todo List")

    onAppeared: Theme.navigationBar.backgroundColor = Style.todoListPageColor

    leftBarItem: IconButtonBarItem {
        icon: IconType.bars

        onClicked: drawer.toggle()
    }

    rightBarItem: ActivityIndicatorBarItem {
        enabled: false/*dataModel.isBusy*/
        visible: enabled
        showItem: showItemAlways
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
        z: 1

        onClicked: drawer.close()
    }

    JsonListModel {
        id: listModel
        //source:
        //keyField: "id"
        //fields: ["id", "title", "completed"]
    }

    AppListView {
        id: listView
        anchors.fill: parent
        model: listModel
    }
}
