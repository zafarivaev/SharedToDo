import QtQuick 2.0
import Felgo 3.0

import "../style"

Page {
    id: root
    title: "Shared To-Do"

    onAppeared: Theme.navigationBar.backgroundColor = Style.welcomePageColor

    Column {
        anchors.centerIn: parent

        AppButton {
            text: qsTr("Sign In")
            flat: false
            backgroundColor: "#4b7bec"

            onClicked: root.navigationStack.push(Qt.resolvedUrl("SignInPage.qml"))
        }

        AppButton {
            text: qsTr("Register")
            flat: false
            backgroundColor: "#fa8231"

            onClicked: root.navigationStack.push(Qt.resolvedUrl("RegisterPage.qml"))
        }
    }
}
