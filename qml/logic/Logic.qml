import QtQuick 2.0

Item {
    signal storeTodo(var todo)

    signal register(string username, string password)
    signal signin(string username, string password)
    signal signout()
}
