class Projeto {
  int id;
  String titulo;
  String descricao;
  DateTime dataPrevisaoEntrega;
  String status;

  Projeto({
    this.id,
    this.titulo,
    this.descricao,
    this.dataPrevisaoEntrega,
    this.status
  });

  factory Projeto.fromJson(Map<String, dynamic> json) {
    return Projeto(
        id: json['id'],
        titulo: json['titulo'],
        descricao: json['descricao'],
        dataPrevisaoEntrega: DateTime.parse( json['dataPrevisaoEntrega'] ),
        status: json['status']['descricao']
    );
  }

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descricao': descricao,
    'dataPrevisaoEntrega': dataPrevisaoEntrega.toString().replaceAll(" ", "T")
  };
}