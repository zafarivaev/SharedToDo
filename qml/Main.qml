import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.12
import "model"
import "logic"
import "pages"

App {
    id: app
    licenseKey: "95884288E5342B0324322800B1BCB523A6E5EAA6052CA07EFE7CD733241A1BD
                 617AAD150D2B77D866D23605F507B0F828BE357A265F0154EAC566294BA39C7
                 F615D685B6165649C8893E9C7216DC95CB843DC29C15F01D9F89650B662FD0B
                 CFE76AB9DC2E2DC2A8F2C507E8CBD04000AF9B981517D4EED461EBC85C42F17
                 53801D7A69C85DC55157C40AC5DFB2280EBF8A792710C0CD01FF2A6181FF085
                 D7743C777E86DC511204E1C00C5D3405AEEC0DBB5FEE433644C4AC7A59B0582
                 39508EE53D2859C9836A40951F3BA8AA99F0E9AFF0F5E056228CB5C682A3B3C
                 FE0237623179C53393C2C064E9C0B781DE96E07411CD1E28E6D3C95046D1151
                 10F7FAF96862908AA51216DCC206D1A3A320762A4CCEECEF587EF9C963B32B6
                 09895D78B332153EA2CF43A6AF48B20331C9413D432DC7C7D6650E156C3A9C3
                 3F20F6B48923D1887BEE5B08A4911B5561F1BD535E"

    Component.onCompleted: {
        logic.fetchTodos()
    }

    onInitTheme: {
        Theme.colors.textColor = "#606060"

        Theme.appButton.radius = Theme.appButton.minimumHeight / 2
        Theme.appButton.minimumWidth = dp(app.width * 0.8)
        Theme.appButton.minimumHeight = dp(45)
        Theme.appButton.verticalMargin = dp(15)
        Theme.appButton.fontCapitalization = Font.MixedCase
        Theme.appButton.textSize = sp(17)
        Theme.appButton.fontBold = false
    }

    Logic {
        id: logic
    }

    DataModel {
        id: dataModel
        dispatcher: logic

        onFetchTodosFailed: nativeUtils.displayMessageBox("Unable to load todos", error, 1)
        onStoreTodoFailed: nativeUtils.displayMessageBox("Failed to store " + viewHelper.formatTitle(todo))
    }

    NavigationStack {
        WelcomePage {
        }

//        Page {
//            title: qsTr("Todo List")

//            NavigationStack {
//                splitView: tablet
//                initialPage: TodoListPage { }
//            }
//        }
    }
}
