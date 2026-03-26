package com.example.todo.ui.screens

import com.example.todo.R
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.calculateEndPadding
import androidx.compose.foundation.layout.calculateStartPadding
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AddCircle
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.MoreVert
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.LayoutDirection
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import com.example.todo.models.Todo
import com.example.todo.viewmodels.TodoViewModel
import kotlinx.coroutines.launch

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TodoScreen(navController: NavController, viewModel: TodoViewModel) {

    val todos = viewModel.todos.filter { !it.isCompleted }

    var expanded by remember { mutableStateOf(false) }
    val snackBarHostState = remember { SnackbarHostState() }
    val coroutineScope = rememberCoroutineScope()

    LaunchedEffect(Unit) {
        val savedStateHandle = navController.currentBackStackEntry?.savedStateHandle

        savedStateHandle?.getLiveData<Boolean>("todo_added")
            ?.observeForever { isAdded ->
                if (isAdded == true) {
                    coroutineScope.launch {
                        snackBarHostState.showSnackbar("Todo Added Successfully ✅")
                    }
                    savedStateHandle.remove<Boolean>("todo_added")
                }
            }

        savedStateHandle?.getLiveData<Boolean>("todo_updated")
            ?.observeForever { isUpdated ->
                if (isUpdated == true) {
                    coroutineScope.launch {
                        snackBarHostState.showSnackbar("Todo Updated Successfully ✏️")
                    }
                    savedStateHandle.remove<Boolean>("todo_updated")
                }
            }
    }


    Scaffold(
        snackbarHost = {
            SnackbarHost(hostState = snackBarHostState)
        },
        topBar = {
            TopAppBar(
                navigationIcon = {
                    Icon(
                        painter = painterResource(id = R.drawable.list2),
                        contentDescription = "Todo",
                        modifier = Modifier.padding(start = 12.dp).size(45.dp),
                        tint = Color.White
                    )
                },
                title = { Text("My Todo List",
                    modifier = Modifier.padding(start=10.dp),
                    color = Color.White,
                    fontWeight = FontWeight.Bold
                )},
                actions = {
                    IconButton(
                        onClick = { viewModel.fetchTodos() }
                    ) {
                        Icon(Icons.Default.Refresh, contentDescription = "Refresh")
                    }
                    IconButton(onClick = { expanded = true }) {
                        Icon(
                            imageVector = Icons.Default.MoreVert,
                            contentDescription = "Menu",
                            Modifier.size(32.dp)
                        )
                    }
                    DropdownMenu(expanded = expanded, onDismissRequest = { expanded = false })
                    {
                        DropdownMenuItem(text = {Text("Completed task")},
                            onClick = { navController.navigate(Screens.CompletedTodo.route) } )
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = Color(0xFF0072ae),
                    titleContentColor = Color.White,
                    actionIconContentColor = Color.White
                )
            )
        },
        floatingActionButton = {
            FloatingActionButton(onClick = {navController.navigate(Screens.AddTodo.upsertTodo(-1))},
                containerColor = Color(0xFF0072AE),
                contentColor = Color.White) {
                Icon(imageVector = Icons.Default.AddCircle,
                    contentDescription = "Add Todo",
                    modifier = Modifier.size(35.dp))
            }
        }
    ) { innerPadding ->
        Column(modifier = Modifier
            .fillMaxSize()
            .padding(top = innerPadding.calculateTopPadding(),
                start = innerPadding.calculateStartPadding(LayoutDirection.Ltr),
                end = innerPadding.calculateEndPadding(LayoutDirection.Ltr),
                )) {
            LazyColumn(modifier = Modifier.fillMaxSize(),
                contentPadding = PaddingValues(
                    start = 12.dp,
                    end = 12.dp,
                    top = 8.dp,
                    bottom = 8.dp + innerPadding.calculateBottomPadding()
                )
            ) {
                item { Spacer(modifier = Modifier.height(2.dp)) }
                items(todos) { todo -> TodoItem(todo = todo, onCheckedChange = { isChecked -> viewModel.updateTodoStatus(todo,isChecked)
                    if(isChecked)
                        coroutineScope.launch {
                            snackBarHostState.showSnackbar("Task Completed")
                        }
                }, onInfoClick = { navController.navigate(Screens.ShowTask.createRoute(todo.id))},
                    onEditClick = { navController.navigate(Screens.AddTodo.upsertTodo(todo.id)) } )}
            }
        }

    }

}

@Composable
fun TodoItem(todo: Todo, onCheckedChange: (Boolean) -> Unit, onInfoClick: () -> Unit, onEditClick: () -> Unit) {

    Card(modifier = Modifier.fillMaxWidth().padding(vertical = 6.dp),
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(
            containerColor = Color(0xFFECECEC)
            // 0xFFececec
        )

    ) {
        Row(modifier = Modifier.fillMaxWidth().padding(16.dp),
            verticalAlignment = Alignment.CenterVertically) {
            Checkbox(checked = todo.isCompleted,
                onCheckedChange = { isChecked -> onCheckedChange(isChecked) } )
            Spacer(modifier = Modifier.width(12.dp))

            Column(modifier = Modifier.weight(1f)) {
                Text(text = todo.title,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold,
                    textDecoration = if (todo.isCompleted)
                        TextDecoration.LineThrough else null)
                Spacer(modifier = Modifier.height(4.dp))
                Text(
                    text = todo.description,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color.Gray
                )
            }

            if(!todo.isCompleted) {
                IconButton(onClick = { onEditClick() } ) {
                    Icon(
                        imageVector = Icons.Default.Edit,
                        contentDescription = "EDIT",
                        tint = Color(0xFF0072AE)

                    )
                }
            }

            if(!todo.isCompleted) {
                IconButton(onClick = { onInfoClick() } ) {
                    Icon(
                        imageVector = Icons.Default.Info,
                        contentDescription = "EDIT",
                        tint = Color(0xFF0072AE)

                    )
                }
            }
        }
    }
}