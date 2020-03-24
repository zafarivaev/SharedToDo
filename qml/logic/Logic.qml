import QtQuick 2.0

Item {
    signal fetchTodos()
    signal storeTodo(var todo)

    signal login(string username, string password)
    signal logout()
}
