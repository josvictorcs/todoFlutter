import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoTile extends StatelessWidget{
  final Todo todo;
  final VoidCallback alternar;
  final VoidCallback deletar;

const TodoTile({
  super.key,
  required this.todo,
  required this.alternar,
  required this.deletar,
});

@override
Widget build(BuildContext context){
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (_) => deletar(),
    direction: DismissDirection.endToStart,
    background: Container(
      color:Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.delete, color: Colors.white),
      ),
    child: CheckboxListTile(
      title: Text(
        todo.titulo,
        style: TextStyle(
          decoration: todo.estaFeito? TextDecoration.lineThrough : null,
          color: todo.estaFeito ? Colors.grey : null,
        ),
      ),
      value: todo.estaFeito,
      onChanged: (_) => alternar(),
      ),
    );
}
}