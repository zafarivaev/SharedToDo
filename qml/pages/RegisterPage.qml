import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

import "../style"

Page {
    readonly property int iconSize: dp(20)

    id: root
    title: qsTr("Register")
    backNavigationEnabled: true

    onAppeared: Theme.colors.tintColor = Style.registerPageColor

    AppPaper {
        id: background
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
        anchors.centerIn: background
        height: grid.height + buttonRegister.anchors.topMargin + buttonRegister.height
        width: grid.width

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
                color: Style.registerPageColor
            }

            Item {
                height: imageEmail.height
                width: imageEmail.width

                Layout.alignment: Qt.AlignHCenter

                Image {
                    id: imageEmail
                    source: Qt.resolvedUrl("../../assets/email_black.png")
                    visible: false
                    height: iconSize
                    width: iconSize
                }

                ColorOverlay {
                    anchors.fill: imageEmail
                    source: imageEmail
                    color: Theme.textColor
                }
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

            Item {
                width: imagePassword.width
                height: imagePassword.height

                Layout.alignment: Qt.AlignHCenter

                Image {
                    id: imagePassword
                    source: Qt.resolvedUrl("../../assets/vpn_key_black.png")
                    visible: false
                    height: iconSize
                    width: iconSize
                }

                ColorOverlay {
                    anchors.fill: imagePassword
                    source: imagePassword
                    color: Theme.textColor
                }
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
            id: buttonRegister
            anchors {
                top: grid.bottom
                topMargin: dp(20)
                horizontalCenter: parent.horizontalCenter
            }
            minimumWidth: background.width * 0.8
            text: qsTr("Register")
            flat: false

            onClicked: {
                root.forceActiveFocus()
                logic.register(txtUsername.text, txtPassword.text)
            }
        }
    }
}
