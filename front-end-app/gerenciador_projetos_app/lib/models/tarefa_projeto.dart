class TarefaProjeto {
  int id;
  String titulo;
  String status;

  TarefaProjeto({
    this.id,
    this.titulo,
    this.status
  });

  factory TarefaProjeto.fromJson(Map<String, dynamic> json) {
    return TarefaProjeto(
        id: json['id'],
        titulo: json['titulo'],
        status: json['status']
    );
  }

  Map<String, dynamic> toJson(int idProjeto) => {
    'titulo': titulo,
    'idProjeto': idProjeto,
  };
}