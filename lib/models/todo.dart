class Todo{
  String titulo;
  bool estaFeito;

  Todo({required this.titulo, this.estaFeito = false});

  Map< String, dynamic> toMap(){
    return{
      'titulo' : titulo,
      'estaFeito': estaFeito,
    };
  }
  factory Todo.fromMap(Map<String, dynamic> map){
    return Todo(
      titulo: map['titulo'] ?? " ",
      estaFeito: map['estaFeito'] ?? false,
    );
  }
}