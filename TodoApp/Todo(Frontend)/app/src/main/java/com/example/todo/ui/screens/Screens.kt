package com.example.todo.ui.screens

import com.example.todo.models.Todo

sealed class Screens(val route: String) {

    object Splash: Screens("splash")
    object TodoList : Screens("todo_list")
    object AddTodo : Screens("add_todo?todoId={todoId}") { fun upsertTodo(todoId: Int) = "add_todo?todoId=${todoId ?: -1}"  }
    object CompletedTodo : Screens("completed_tasks")
    object ShowTask : Screens("show_task/{id}") { fun createRoute(id: Int) = "show_task/$id" }
}