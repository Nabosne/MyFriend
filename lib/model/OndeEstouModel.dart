class OndeEstouModel {
  String local;
  String espaco;
  String texto;

  OndeEstouModel({this.local, this.espaco, this.texto});

  OndeEstouModel.fromJson(Map<String, dynamic> json) {
    local = json['local'];
    espaco = json['espaco'];
    texto = json['texto'];
  }
}
