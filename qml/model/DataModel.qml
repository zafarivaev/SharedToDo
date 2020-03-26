import QtQuick 2.0
import Felgo 3.0

Item {
    signal signedIn()
    signal fetched(var todos)

    signal fetchTodosFailed(var error)
    signal storeTodoFailed(var todo, var error)

    property alias dispatcher: logicConnection.target
    property alias todoModel: jsonModel

    //readonly property bool isBusy:
    readonly property bool isSignedIn: firebaseAuth.authenticated

    Connections {
        id: logicConnection

        onFetchTodos: {
            db.getValue("tasks")
        }

        onStoreTodo: {
            db.setValue("tasks", todo)
        }

        onRegister: {
            console.log("Registering user...")
            firebaseAuth.registerUser(username, password)
        }

        onSignin: firebaseAuth.loginUser(username, password)
        onSignout: firebaseAuth.logoutUser()
    }

    FirebaseAuth {
        id: firebaseAuth

        onUserRegistered: {
            console.debug("User login " + success + " - " + message)

            signedIn()
            app.settings.setValue("token", userToken)
        }

        onLoggedIn: {
            console.debug("User login " + success + " - " + message)

            signedIn()
            app.settings.setValue("token", userToken)
        }
    }

    FirebaseDatabase {
        id: db
        realtimeValueKeys: ["tasks"]

        Component.onCompleted: {
            setValue("tasks", "testing task")
        }

        onRealtimeValueChanged: {
            if (success) {
                console.debug("Realtime value " + value + " for key " + key)
            }
            else {
                console.debug("Realtime error with message: "  + value)
            }
        }

        onReadCompleted: {
            if (success) {
                console.debug("Read value " + value + " for key " + key)
            }
            else {
                console.debug("Error with message: "  + value)
            }

            fetched(value)
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

    function signInWithToken(token) {
        firebaseAuth.loginUserWithToken(token)
    }

    Item {
        property var todos: [
            {
                createdBy: "tokhirovdoniyor@gmail.com",
                id: "11213",
                isDone: false,
                timestamp: 10109239208309,
                title: "This is my todo"
            },
            {
                createdBy: "z.ivaev@mail.ru",
                id: "12346",
                isDone: true,
                timestamp: 10109239208309,
                title: "This is zafar's todo"
            }
        ]

        id: _
    }
}
