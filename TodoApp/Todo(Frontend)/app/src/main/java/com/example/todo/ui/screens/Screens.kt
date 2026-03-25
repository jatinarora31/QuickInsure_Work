package com.example.todo.ui.screens

sealed class Screens(val route: String) {

    object Splash: Screens("splash")
    object TodoList : Screens("todo_list")
    object AddTodo : Screens("add_todo")
    object CompletedTodo : Screens("completed_tasks")
    object ShowTask : Screens("show_task/{id}") { fun createRoute(id: Int) = "show_task/$id" }
}