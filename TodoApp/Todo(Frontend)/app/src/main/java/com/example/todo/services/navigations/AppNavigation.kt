package com.example.todo.services.navigations

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import com.example.todo.R
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.scale
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.*
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.todo.ui.screens.AddTodoScreen
import com.example.todo.ui.screens.CompletedTasks
import com.example.todo.ui.screens.Screens
import com.example.todo.ui.screens.ShowTask
import com.example.todo.ui.screens.TodoScreen
import com.example.todo.viewmodels.TodoViewModel

@Composable
fun AppNavigation() {

    val navController = rememberNavController()
    val viewModel: TodoViewModel = androidx.lifecycle.viewmodel.compose.viewModel()


    NavHost(navController = navController, startDestination = Screens.Splash.route)
    {
        composable(route = Screens.Splash.route) { SplashScreen(navController) }

        composable(Screens.TodoList.route) { TodoScreen(navController,viewModel) }
        composable(Screens.AddTodo.route) { AddTodoScreen(navController,viewModel) }
        composable(Screens.CompletedTodo.route) { CompletedTasks(navController,viewModel) }
        composable(route = Screens.ShowTask.route,
            arguments = listOf(navArgument("id") { type = NavType.IntType })) { backStackEntry ->
            val id = backStackEntry.arguments?.getInt("id") ?: 0
            ShowTask(navController,viewModel,id) }

    }
}
@Composable
fun SplashScreen(navController: NavHostController) {

    var startAnimation by remember { mutableStateOf(false) }

    val scale by animateFloatAsState(
        targetValue = if (startAnimation) 1f else 0.5f,
        animationSpec = tween(durationMillis = 800)
    )

    val alpha by animateFloatAsState(
        targetValue = if (startAnimation) 1f else 0f,
        animationSpec = tween(durationMillis = 800)
    )

    LaunchedEffect(Unit) {
        startAnimation = true

        kotlinx.coroutines.delay(1200)
        navController.navigate(Screens.TodoList.route) {
            popUpTo(Screens.Splash.route) { inclusive = true }
        }
    }

    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.scale(scale).alpha(alpha)) {

            Image(
                painter = painterResource(id = R.drawable.list),
                contentDescription = "App Logo",
                modifier = Modifier.size(120.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "Todo App",
                style = MaterialTheme.typography.headlineLarge,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF0072ae)
            )
        }
    }
}