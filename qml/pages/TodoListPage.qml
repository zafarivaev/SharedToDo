import Felgo 3.0
import QtQuick 2.0

Page {
    id: page
    title: qsTr("Todo List")

    rightBarItem: NavigationBarRow {
        ActivityIndicatorBarItem {
            enabled: dataModel.isBusy
            visible: enabled
            showItem: showItemAlways
        }

        IconButtonBarItem {
            icon: IconType.plus
            showItem: showItemAlways
            onClicked: {
                var title = qsTr("New Todo")
                logic.addTodo(title)
            }
        }
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
