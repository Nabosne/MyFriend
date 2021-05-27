class LocaisModel {
  List<Locais> locais;

  LocaisModel({this.locais});

  LocaisModel.fromJson(Map<String, dynamic> json) {
    if (json['locais'] != null) {
      locais = new List<Locais>();
      json['locais'].forEach((v) {
        locais.add(new Locais.fromJson(v));
      });
    }
  }
}

class Locais {
  int beaconLocal;
  String nome;
  String telefone;
  String texto;

  Locais({this.beaconLocal, this.nome, this.telefone, this.texto});

  Locais.fromJson(Map<String, dynamic> json) {
    beaconLocal = json['beacon_local'];
    nome = json['nome'];
    telefone = json['telefone'];
    texto = json['texto'];
  }
}
