import QtQuick 2.0
import Felgo 3.0

Item {
    signal signedIn()
    signal signedOut()

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
                title: text
            }

            db.setValue(dbKeyTodos + "/" + new Date().getTime(), jsonTodo)
        }

        onEditTodo:
            db.setValue(dbKeyTodos + "/" + _.todos[index].id + "/title", text,
                        function (success, message) {
                            if (success)
                                console.debug("Edit index " + index + " successful")
                            else
                                console.debug("Couldn't edit because: " + message)
                        })

        onDeleteTodo:
            db.setValue(dbKeyTodos + "/" + _.todos[index].id, null,
                        function (success, message) {
                            if (success)
                                console.debug("Delete index " + index + " successful")
                            else
                                console.debug("Couldn't delete because: " + message)
                        })

        onMarkCompleted:
            db.setValue(dbKeyTodos + "/" + _.todos[index].id + "/isDone", true,
                        function (success, message) {
                            if (success)
                                console.debug("Mark complete index " + index + " successful")
                            else
                                console.debug("Couldn't mark complete because: " + message)
                        })
        onMarkNotCompleted:
            db.setValue(dbKeyTodos + "/" + _.todos[index].id + "/isDone", false,
                        function (success, message) {
                            if (success)
                                console.debug("Mark incomplete index " + index + " successful")
                            else
                                console.debug("Couldn't mark incomplete because: " + message)
                        })

        onRegister: firebaseAuth.registerUser(username, password)
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

        onAuthenticatedChanged: {
            if (authenticated)
                signedIn()
            else
                signedOut()
        }

        onUserRegistered: {
            console.debug("User login " + success + " - " + message)
        }

        onLoggedIn: {
            console.debug("User login " + success + " - " + message)
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

                if (value === undefined && _.todos.length === 1) {
                    _.todos = []
                }
            }

        }

        onWriteCompleted: {
            if (success)
                console.debug("Successfully wrote to DB")
            else
                console.debug("Write failed with error: " + message)
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

        id: _
    }
}
