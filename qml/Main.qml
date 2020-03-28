import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.12
import "model"
import "logic"
import "pages"

App {
    id: app
    licenseKey: "6D4B3C96BAFE202393EC9D6E55F7881D4DAD07A617114C61E6AF2E1C6D84E6D421FB11AE4242B37BEBCF88EB1188B8E5E39DDE8641515A0EBD9FB55E63F1DF8A8AAC0C4939817D54228D96E21F22276B2E88E250E03E8A2A72164F60C0091E68C727B2649F4A9E1ED5925FAD28123E03C0A6614D7DF75F95D9C783ECF0CDA732D9489907E809CCDA9ACE6093AD426E87F76076F2E6DB134A08A350E701EC45BEB259B50688134E56D6C12E91AD44BA4A652E4BDD4160E8FBAFC8867AE36D08666AFEF073195B9C4F230B4C34C3D87C0FCCFE89D74F94BCC2F91DF1E9B61EE6F57E09971F45682A7739D3972AC33361D71D3EBBF1B289A11D1A4A16C63F6AB1DFEE87F31B5593557317C3E7C84507833D778D25CAE50515885120D328B2A7F443E450989F62DB1E5920EFAE23E2B7B79E77F91FDF1DCCDFA664238797F623C7A1C04A5F0A4355ACB27068F35B767D4F02"

    Component.onCompleted: {
        fadeOutTransition.opacity = 0

        var dpi = app.height / app.heightInInches
        var scaleFactor = dpi / 160

        Theme.appButton.radius = Theme.appButton.minimumHeight / 2
        Theme.appButton.minimumWidth = app.width * 0.8 / scaleFactor

        Theme.appButton.minimumHeight = 50
        Theme.appButton.verticalMargin = 15
        Theme.appButton.fontCapitalization = Font.MixedCase
        Theme.appButton.textSize = 18
        Theme.appButton.fontBold = false
    }

    onInitTheme: {
        Theme.colors.textColor = "#606060"

        Theme.listItem.textColor = "#303030"
        Theme.listItem.detailTextColor = "#808080"
        Theme.listItem.fontSizeText = 18
    }

    Logic {
        id: logic
    }

    DataModel {
        id: dataModel
        dispatcher: logic

        onSignedIn: navStack.clearAndPush(todoListComponent)
        onSignedOut: navStack.clearAndPush(welcomeComponent)

        onStoreTodoFailed: nativeUtils.displayMessageBox("Failed to store " + viewHelper.formatTitle(todo))
    }

    NavigationStack {
        id: navStack

        initialPage: welcomeComponent
    }

    Rectangle {
        id: fadeOutTransition
        anchors.fill: navStack
        color: Theme.backgroundColor
        visible: opacity !== 0
        opacity: 1

        Behavior on opacity {
            NumberAnimation {
                property: "opacity"
                duration: 200
                easing.type: Easing.InQuad
            }
        }
    }

    Component {
        id: welcomeComponent
        WelcomePage {
            onSigninClicked: navigationStack.push(signinComponent)
            onRegisterClicked: navigationStack.push(registerComponent);
        }
    }

    Component {
        id: todoListComponent
        TodoListPage {
            model: dataModel.todoModel
        }
    }

    Component {
        id: signinComponent
        SignInPage {
        }
    }

    Component {
        id: registerComponent
        RegisterPage {
        }
    }
}
