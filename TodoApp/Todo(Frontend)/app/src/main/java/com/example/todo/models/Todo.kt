package com.example.todo.models

import com.google.gson.annotations.SerializedName
import java.util.Date

data class Todo(val id:Int,
                val title:String,
                val description:String,
                @SerializedName("is_completed") val is_completed: Boolean,
                @SerializedName("created_at") val createdAt: String)
{
    val isCompleted: Boolean
        get() = is_completed

}