import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main(){
  runApp( TodoApp());
}

class TodoApp extends StatelessWidget{
  TodoApp({super.key});
  final ValueNotifier <bool> isDark = ValueNotifier(false);

  Widget build(BuildContext context){
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, dark, _){
        return MaterialApp(
          title: "Lista de tarefas",
          debugShowCheckedModeBanner: false,
          themeMode: dark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: HomePage(isDark: isDark)
        );
      }
      );
  }
}