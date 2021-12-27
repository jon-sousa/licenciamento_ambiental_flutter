import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/models/solicitacao.dart';
import 'package:licenciamento_ambiental/pages/solicitacao_page.dart';

class CardSolicitacao extends StatelessWidget {
  Solicitacao _solicitacao;

  CardSolicitacao(this._solicitacao, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 0.8 * MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              _solicitacao.imovel,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 8,
            ),
            Text('Estado: ${_solicitacao.estados.last.nome}'),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SolicitacaoPage(_solicitacao)));
                },
                child: const Text('Abrir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
