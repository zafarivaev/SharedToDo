import QtQuick 2.0

Item {
    signal storeTodo(var text)
    signal editTodo(var index, var text)
    signal deleteTodo(var index)

    signal markCompleted(var index)
    signal markNotCompleted(var index)

    signal register(string username, string password)
    signal signin(string username, string password)
    signal signout()
}
