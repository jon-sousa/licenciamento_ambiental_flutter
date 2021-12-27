import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/models/estado.dart';
import 'package:licenciamento_ambiental/models/solicitacao.dart';

class SolicitacaoPage extends StatelessWidget {
  final Solicitacao _solicitacao;

  const SolicitacaoPage(this._solicitacao, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitação'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 48),
          Text(_solicitacao.imovel),
          Expanded(
            child: ListView(
              children: _buildEstadosListTile(),
            ),
          )
        ],
      ),
    );
  }

  List<ListTile> _buildEstadosListTile() {
    List<ListTile> tiles = [];

    for (var estado in _solicitacao.estados) {
      var tile = ListTile(
        title: Text(estado.nome),
        subtitle: Text(estado.data),
      );

      tiles.add(tile);
    }
    return tiles;
  }
}
