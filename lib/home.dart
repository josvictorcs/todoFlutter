import 'package:flutter/material.dart';

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _tasks = [];

//Adicionar tarefa
void _addTask(){
  final text = _controller.text;
  if(text.isNotEmpty){
    setState(() {
      _tasks.add(text);
      _controller.clear();
    });
  }
}
//Remover tarefa da lista
void _removetask(int index){
  setState(() {
    _tasks.removeAt(index);
  });
}
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Lista de tarefas'),
    ),
    body: Padding(
      padding: EdgeInsetsGeometry.all(16.0),
      child: Column(
        children: [
          // Campo text e botão adicionar
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Adicionar Tarefa!',
                  ),
                )
                ),
                IconButton(
                  onPressed: _addTask,
                  icon: Icon(Icons.add)
                  ),
            ],
          ),
          SizedBox(height: 16),

          //Lista de tarefas
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: IconButton(
                    onPressed: () => _removetask(index),
                     icon: Icon(Icons.delete)
                     ),
                );
              }
              )
              )
        ],
      ),
      ),
  );
}
}