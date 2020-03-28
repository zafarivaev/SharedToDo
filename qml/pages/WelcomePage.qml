import QtQuick 2.0
import Felgo 3.0

import "../style"

Page {
    signal signinClicked()
    signal registerClicked()

    id: root
    title: "Shared To-Do"

    onAppeared: Theme.colors.tintColor = Style.welcomePageColor

    Column {
        anchors.centerIn: parent

        AppButton {
            text: qsTr("Sign In")
            flat: false
            backgroundColor: "#4b7bec"

            onClicked: signinClicked()
        }

        AppButton {
            text: qsTr("Register")
            flat: false
            backgroundColor: "#fa8231"

            onClicked: registerClicked()
        }
    }
}
