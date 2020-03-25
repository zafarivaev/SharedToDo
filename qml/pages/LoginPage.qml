import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Page {
    id: loginPage
    title: qsTr("Sign In")
    backNavigationEnabled: true

    AppPaper {
        id: loginForm
        anchors.centerIn: parent
        width: content.width + dp(48)
        height: content.height + dp(50)
        radius: dp(15)
        shadowOffsetElevated: dp(2)
        shadowSizeElevated: dp(2)
        elevated: true
    }

    Item {
        id: content
        anchors.centerIn: loginForm
        height: grid.height + buttonSignIn.anchors.topMargin + buttonSignIn.height
        width: Math.max(grid.width, buttonSignIn.width)

        GridLayout {
            id: grid
            anchors.horizontalCenter: parent.horizontalCenter
            columnSpacing: dp(20)
            rowSpacing: dp(10)
            columns: 2

            AppText {
                Layout.topMargin: dp(8)
                Layout.bottomMargin: dp(50)
                Layout.columnSpan: 2
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("Input your credentials")
            }

            Image {
                id: imageEmail
                anchors.verticalCenter: columnEmail.verticalCenter
                source: Qt.resolvedUrl("../../assets/email_black.png")
                visible: false
                Layout.alignment: Qt.AlignHCenter

            }

            ColorOverlay {
                anchors.fill: imageEmail
                source: imageEmail
                color: Theme.textColor
            }

            Column {
                id: columnEmail
                Layout.preferredWidth: dp(200)

                AppText {
                    text: qsTr("Email")
                    font.pixelSize: sp(12)
                }

                AppTextField {
                    id: txtUsername
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    showClearButton: true
                    font.pixelSize: sp(14)
                    borderColor: Theme.tintColor
                    borderWidth: !Theme.isAndroid ? dp(2) : 0
                }
            }

            Image {
                id: imagePassword
                anchors.verticalCenter: columnPassword.verticalCenter
                source: Qt.resolvedUrl("../../assets/vpn_key_black.png")
                visible: false
                Layout.alignment: Qt.AlignHCenter
            }

            ColorOverlay {
                anchors.fill: imagePassword
                source: imagePassword
                color: Theme.textColor
            }

            Column {
                id: columnPassword
                Layout.preferredWidth: dp(200)

                AppText {
                    text: qsTr("Password")
                    font.pixelSize: sp(12)
                }

                AppTextField {
                    id: txtPassword
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    showClearButton: true
                    font.pixelSize: sp(14)
                    borderColor: Theme.tintColor
                    borderWidth: !Theme.isAndroid ? dp(2) : 0
                    echoMode: TextInput.Password
                }
            }
        }

        AppButton {
            id: buttonSignIn
            anchors {
                top: grid.bottom
                topMargin: dp(20)
                horizontalCenter: parent.horizontalCenter
            }
            minimumWidth: loginForm.width * 0.8
            text: qsTr("Sign in")
            flat: false

            onClicked: {
                loginPage.forceActiveFocus() // move focus away from text fields

                // call login action
                logic.login(txtUsername.text, txtPassword.text)
            }
        }
    }
}
