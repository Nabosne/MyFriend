class DestinosModel {
  List<Destinos> destinos;

  DestinosModel({this.destinos});

  DestinosModel.fromJson(Map<String, dynamic> json) {
    if (json['destinos'] != null) {
      destinos = new List<Destinos>();
      json['destinos'].forEach((v) {
        destinos.add(new Destinos.fromJson(v));
      });
    }
  }

}

class Destinos {
  String nome;
  List<Percursos> percursos;

  Destinos({this.nome, this.percursos});

  Destinos.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    if (json['percursos'] != null) {
      percursos = new List<Percursos>();
      json['percursos'].forEach((v) {
        percursos.add(new Percursos.fromJson(v));
      });
    }
  }

}

class Percursos {
  String espacoInicio;
  String espacoFim;
  int sequencia;
  String instrucao;

  Percursos(
      {this.espacoInicio, this.espacoFim, this.sequencia, this.instrucao});

  Percursos.fromJson(Map<String, dynamic> json) {
    espacoInicio = json['espaco_inicio'];
    espacoFim = json['espaco_fim'];
    sequencia = json['sequencia'];
    instrucao = json['instrucao'];
  }


}
