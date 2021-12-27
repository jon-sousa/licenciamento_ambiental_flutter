import 'package:licenciamento_ambiental/models/estado.dart';

class Solicitacao {
  int? _id;
  String _imovel;
  String? _ultimoEstado;
  List<Estado> estados = [];

  Solicitacao(this._id, this._imovel, this._ultimoEstado);

  void fromMap(Map<String, dynamic> map) {
    if (map.containsKey('id')) {
      _id = map['id'];
    }

    if (map.containsKey('imovel')) {
      _imovel = map['imovel'];
    }

    if (map.containsKey('estados')) {
      for (var estadoMap in map['estados']) {
        var estado = Estado(estadoMap['nome'], estadoMap['data']);
        estados.add(estado);
      }
    }
  }

  get imovel {
    return _imovel;
  }

  get ultimoEstado {
    return _ultimoEstado;
  }
}
