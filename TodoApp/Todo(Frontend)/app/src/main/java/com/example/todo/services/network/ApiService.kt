package com.example.todo.services.network

import com.example.todo.models.CreateTodoRequest
import com.example.todo.models.Todo
import com.example.todo.models.UpdateStatusTododRequest
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.PATCH
import retrofit2.http.POST
import retrofit2.http.PUT
import retrofit2.http.Path

interface ApiService {

    @GET("/todos")
    suspend fun getAllTodos(): Response<List<Todo>>

    @POST("/todos")
    suspend fun addTodo(@Body request: CreateTodoRequest) : Response<Todo>

    @PATCH("/todos/{id}/update_status")
    suspend fun updateStatus(@Path("id") id: Int, @Body request: UpdateStatusTododRequest) : Response<Todo>

    @PUT("/todos/{id}")
    suspend fun updateTodo(@Path("id") id: Int, @Body createTodoRequest: CreateTodoRequest) : Response<Todo>


}