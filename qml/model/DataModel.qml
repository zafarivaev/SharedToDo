import QtQuick 2.0
import Felgo 3.0

Item {
    property alias dispatcher: logicConnection.target

    //readonly property bool isBusy:
    readonly property bool userLoggedIn: _.userLoggedIn

    signal fetchTodosFailed(var error)
    signal storeTodoFailed(var todo, var error)

    Connections {
        id: logicConnection

        onFetchTodos: {
            // load from api
        }

        onStoreTodo: {
            // store with api
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

            if (success) {
                loginDialog.title = "Success!"
            }
            else {
                loginDialog.title = "An issue occured!"
            }

            _.userLoggedIn = true
        }

        onLoggedIn: {
            console.debug("User login " + success + " - " + message)

            if(success) {
                loginDialog.title = "Success!"
            } else {
                loginDialog.title = "An issue occured!"
            }

            _.userLoggedIn = true
        }
    }

    FirebaseDatabase {
        id: db

        onReadCompleted: {
            if (success) {
                console.debug("Read value " +  value + " for key " + key)
            }
            else {
                console.debug("Error with message: "  + value)
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

    Item {
        id: _
        property bool userLoggedIn: false

    }
}
