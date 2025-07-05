import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';
import '../widgets/todo_tile.dart';

class HomePage extends StatefulWidget{
  final ValueNotifier<bool> isDark;
  const HomePage({super.key, required this.isDark});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  final _controller = TextEditingController();
  List <Todo> _tasks = [];
  bool get _dark => widget.isDark.value; //caramba, super importante
  @override
  void initState(){
    super.initState();
    _loadTasks();
  }
  
  Future<void> _loadTasks() async{
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('tasks');
    final theme = prefs.getBool('dark')?? false;
    
    if (data != null){
      final List decoded = jsonDecode(data);
      _tasks = decoded.map((item) => Todo.fromMap(item)).toList();
    }
    widget.isDark.value = theme;
    
  }
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_tasks.map((e) => e.toMap()).toList());
    prefs.setString('tasks', data);
    prefs.setBool('dark', widget.isDark.value);
  }

  void _add(){
    final text = _controller.text;
    if(text.isNotEmpty){
      setState(() {
        _tasks.add(Todo(titulo: text));
        _controller.clear();
        _saveTasks();
      });
    }
  }

  void _alterar(int index){
    setState(() {
      _tasks[index].estaFeito = !_tasks[index].estaFeito;
      _saveTasks();
    });
  }

  void _deletar(int index){
    setState(() {
      _tasks.removeAt(index);
      _saveTasks();
    });
  }

  void _theme(){
    setState(() {
      widget.isDark.value = !widget.isDark.value;
      _saveTasks();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas tarefas"),
        actions: [
          IconButton(
            icon: Icon(_dark ? Icons.dark_mode: Icons.light_mode),
            onPressed: _theme,
            )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _add(),
                    decoration: InputDecoration(
                      labelText: 'Nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                ElevatedButton(
                  onPressed: _add,
                  child: Text("Adicionar"),
                )
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _tasks.isEmpty
              ? Center(child: Text("Nenhuma tarefa ainda :("))
              : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index){
                  return TodoTile(
                    todo: _tasks[index],
                     alternar: () => _alterar(index) ,
                      deletar: () => _deletar(index),
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