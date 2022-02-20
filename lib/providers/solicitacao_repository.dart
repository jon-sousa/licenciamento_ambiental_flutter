import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:licenciamento_ambiental/models/solicitacao.dart';
import 'package:licenciamento_ambiental/providers/shared_preference_repository.dart';

class SolicitacaoRepository {
  Future<List<Solicitacao>> getSolicitacoes() async {
    var headers = await _configuraHeaders();

    var response = await http.get(
      Uri.parse(
        'http://localhost:3000/solicitacao/consultar-solicitacoes-por-usuario/',
      ),
      headers: headers,
    );
    var listaDeSolicitacoes = jsonDecode(response.body) as List;
    List<Solicitacao> solicitacoes = [];

    for (var solicitacaoDynamic in listaDeSolicitacoes) {
      var solicitacaoMap = solicitacaoDynamic as Map<String, dynamic>;

      Solicitacao solicitacao = (Solicitacao(0, '', ''));
      solicitacao.fromMap(solicitacaoMap);

      solicitacoes.add(solicitacao);
    }
    return solicitacoes;
  }

  cadastrarSolicitacao(Map<String, dynamic> solicitacao) async {
    var headers = await _configuraHeaders();
    headers.addAll({
      'Content-Type': 'multipart/form-data',
      'accept': 'multipart/form-data',
    });
    print(solicitacao);

    var multiPartForm = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:3000/solicitacao/cadastrar-solicitacao'),
    );
    multiPartForm.headers.addAll(headers);
    multiPartForm.fields['imovel'] = solicitacao['imovel'];
    for (Map<String, Uint8List> documento in solicitacao['files']) {
      multiPartForm.files.add(http.MultipartFile.fromBytes(
        'files',
        documento.values.first,
        filename: documento.keys.first,
      ));
    }
    var response = await multiPartForm.send();

    if (_existeErro(response.statusCode)) {
      throw Exception('Erro ao cadaastrar solicitacao');
    }
  }

  bool _existeErro(int httpResponseCode) {
    if (httpResponseCode >= 400) {
      return true;
    }
    return false;
  }

  Future<Map<String, String>> _configuraHeaders() async {
    SharedPreferenceRepository? sharedPreferenceRepository =
        await SharedPreferenceRepository.getInstance();

    String token = sharedPreferenceRepository?.getToken() ?? '';

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    return headers;
  }
}
