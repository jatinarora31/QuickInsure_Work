package com.example.todo.viewmodels

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.todo.models.CreateTodoRequest
import com.example.todo.models.Todo
import com.example.todo.repositories.TodoRepository
import kotlinx.coroutines.launch

class TodoViewModel : ViewModel() {

    private val repository = TodoRepository()

    var todos = mutableStateListOf<Todo>()
    var todosError by mutableStateOf<String?>(null)
    var isLoading by mutableStateOf(false)

    init {
        fetchTodos()
    }

    fun fetchTodos() {
        viewModelScope.launch {

            isLoading = true
            todosError = null

            val result = repository.getTodos()

            result.onSuccess {
                    fetchedList ->
                val sortedList = fetchedList.sortedByDescending { it.id }
                todos.clear()
                todos.addAll(sortedList)
            }
            result.onFailure {
                todosError = it.message
            }
            isLoading = false
        }
    }

    fun addTodo(title: String, description: String, onSuccess: () -> Unit) {

        viewModelScope.launch {
            isLoading = true
            val result = repository.createTodo(CreateTodoRequest(title,description))
            result.onSuccess {
                    todo -> todos.add(0,todo)
                fetchTodos()
                onSuccess()
            }
            result.onFailure {
                todosError = it.message
            }
            isLoading = false
        }
    }

    fun updateTodoStatus(todo: Todo, isChecked: Boolean) {
        viewModelScope.launch {
            val index = todos.indexOfFirst { it.id == todo.id }
            if (index != -1) {
                todos[index] = todo.copy(is_completed = isChecked)
            }
            val result = repository.updateTodoStatus(todo.id, isChecked)

            result.onFailure {
                if (index != -1) {
                    todos[index] = todo
                }
                todosError = it.message
            }
        }
    }

}