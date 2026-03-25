package com.example.todo.repositories

import android.util.Log
import com.example.todo.BuildConfig
import com.example.todo.models.CreateTodoRequest
import com.example.todo.services.network.RetrofitInstance
import com.example.todo.models.Todo
import com.example.todo.models.UpdateStatusTododRequest
import com.example.todo.services.network.ErrorConverter
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import retrofit2.Response

class TodoRepository {

    suspend fun <T> handleApiCall(apiCall: suspend () -> Response<T>): Result<T> {
        try {
            val response = withContext(Dispatchers.IO) { apiCall() }

            if(response.isSuccessful && response.body() != null) {
                return Result.success(response.body()!!)
            } else if(response.isSuccessful) {
                return Result.failure(IllegalStateException("No Data found"))
            } else {
                return ErrorConverter.parseError(response)?.error.let {
                    Result.failure(
                        IllegalStateException(
                            it ?: "Something went wrong"
                        )
                    )
                }
            }

        } catch (e: Exception) {
            if(BuildConfig.DEBUG) {
                Log.e("RETROFIT ERROR", "Error during API call", e)
            }
            return Result.failure(IllegalStateException("Something went wrong"))
        }
    }

    suspend fun getTodos(): Result<List<Todo>> {
        return handleApiCall(apiCall = suspend { RetrofitInstance.api.getAllTodos() })
    }

    suspend fun createTodo(todoRequest: CreateTodoRequest) : Result<Todo> {
        return handleApiCall ( apiCall = suspend { RetrofitInstance.api.addTodo(todoRequest) } )
    }

    suspend fun updateTodoStatus(id: Int, status: Boolean) : Result<Todo> {
        return handleApiCall ( apiCall = suspend { RetrofitInstance.api.updateStatus(id,UpdateStatusTododRequest(status)) })
    }

}