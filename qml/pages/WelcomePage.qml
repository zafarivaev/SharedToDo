import QtQuick 2.0
import Felgo 3.0

import "../style"

Page {
    signal signinClicked()
    signal registerClicked()

    id: root
    title: "Shared To-Do"

    onAppeared: Theme.colors.tintColor = Style.welcomePageColor

    onPushed: pushAnim.start()

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
