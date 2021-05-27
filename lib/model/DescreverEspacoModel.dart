class DescreverEspacoModel {
  String local;
  String espaco;
  String texto;

  DescreverEspacoModel({this.local, this.espaco, this.texto});

  DescreverEspacoModel.fromJson(Map<String, dynamic> json) {
    local = json['local'];
    espaco = json['espaco'];
    texto = json['texto'];
  }
}
