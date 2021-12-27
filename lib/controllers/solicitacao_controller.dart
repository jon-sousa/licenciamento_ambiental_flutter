import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/models/solicitacao.dart';
import 'package:licenciamento_ambiental/providers/solicitacao_repository.dart';

class SolicitacaoController extends ChangeNotifier {
  final SolicitacaoRepository _solicitacaoRepository = SolicitacaoRepository();

  cadastrarSolicitacao(String imovel) async {
    await _solicitacaoRepository.cadastrarSolicitacao(imovel);
    notifyListeners();
  }

  Future<List<Solicitacao>> consultarSolicitacoes() async {
    var solicitacoes = await _solicitacaoRepository.getSolicitacoes();
    notifyListeners();
    return solicitacoes;
  }
}
