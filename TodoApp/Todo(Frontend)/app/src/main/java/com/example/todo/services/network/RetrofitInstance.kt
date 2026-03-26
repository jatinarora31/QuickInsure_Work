package com.example.todo.services.network

import com.example.todo.BuildConfig
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object RetrofitInstance {

    private val BASE_URL = "http://172.30.1.49:3000"
    // 172.30.1.49
    //192.168.0.105
    val api: ApiService by lazy {

        val httpBuilder = OkHttpClient.Builder()
            .readTimeout(5, TimeUnit.MINUTES)
            .connectTimeout(30, TimeUnit.SECONDS)


        if(BuildConfig.DEBUG) {
            httpBuilder.addInterceptor(HttpLoggingInterceptor())
        }

        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .client(httpBuilder.build())
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }

}