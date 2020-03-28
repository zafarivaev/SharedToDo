import QtQuick 2.0
import Felgo 3.0

Item {
    signal signedIn()

    signal storeTodoFailed(var todo, var error)

    property alias dispatcher: logicConnection.target
    property alias todoModel: jsonModel

    //readonly property bool isBusy:
    readonly property bool isSignedIn: firebaseAuth.authenticated

    readonly property string dbKeyTodos: "tasks"

    Connections {
        id: logicConnection

        onStoreTodo: {
            var time = new Date().getTime()
            var jsonTodo = {
                createdBy: firebaseAuth.email,
                id: time,
                isDone: false,
                timestamp: time,
                title: todo
            }

            db.setValue(dbKeyTodos + "/" + new Date().getTime(), jsonTodo)
        }

        onRegister: {
            console.log("Registering user...")
            firebaseAuth.registerUser(username, password)
        }

        onSignin: firebaseAuth.loginUser(username, password)
        onSignout: firebaseAuth.logoutUser()
    }

    FirebaseConfig {
        id: fbConfig
        projectId: "shared-to-do"
        databaseUrl: "https://shared-to-do.firebaseio.com"
        apiKey: Qt.platform.os === "android"
                ? "AIzaSyCTg40eQc-13KuCEZI90zTXzNuAnBNc9is"
                : ""
        applicationId: Qt.platform.os === "android"
                       ? "1:654007037478:android:61ced7e4ad0cd194cac0e7"
                       : 0
    }

    FirebaseAuth {
        id: firebaseAuth
        config: fbConfig

        onUserRegistered: {
            console.debug("User login " + success + " - " + message)

            if (success)
                signedIn()
        }

        onLoggedIn: {
            console.debug("User login " + success + " - " + message)

            if (success)
                signedIn()
        }
    }

    FirebaseDatabase {
        id: db
        config: fbConfig
        realtimeValueKeys: ["tasks"]

        onRealtimeValueChanged: {
            if (success) {
                console.debug("Realtime value " + value + " for key " + key)

                let todos = []
                for (let id in value) {
                    todos.push(value[id])
                }
                _.todos = todos
            }
            else {
                console.debug("Realtime error with message: "  + value)
            }

        }

        onWriteCompleted: {
            if (success) {
                console.debug("Successfully wrote to DB")
            }
            else {
                console.debug("Write failed with error: " + message)
            }
        }
    }

    JsonListModel {
        id: jsonModel
        source: _.todos
        keyField: "id"
        fields: ["createdBy", "id", "isDone", "timestamp", "title"]
    }

    Item {
        property var todos: []

        onTodosChanged: {
            console.log("todos: " + JSON.stringify(todos))
        }

        id: _
    }
}
