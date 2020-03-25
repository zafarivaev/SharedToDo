import QtQuick 2.0
import Felgo 3.0

Page {
    id: root
    title: "Shared To-Do"

    Component.onCompleted: Theme.navigationBar.backgroundColor = "#2d98da"

    Column {
        anchors.centerIn: parent

        AppButton {
            text: qsTr("Sign In")
            flat: false
            backgroundColor: "#4b7bec"

            onClicked: {
                root.navigationStack.push(Qt.resolvedUrl("LoginPage.qml"))
                Theme.navigationBar.backgroundColor = "#4b7bec"
            }
        }

        AppButton {
            text: qsTr("Register")
            flat: false
            backgroundColor: "#fa8231"

            onClicked: {
                root.navigationStack.push(Qt.resolvedUrl("RegisterPage.qml"))
                Theme.navigationBar.backgroundColor = "#fa8231"
            }
        }
    }
}
