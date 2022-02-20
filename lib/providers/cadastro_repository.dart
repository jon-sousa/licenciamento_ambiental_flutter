import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:licenciamento_ambiental/models/usuario.dart';
import 'package:licenciamento_ambiental/providers/shared_preference_repository.dart';

class CadastroRepository {
  Future<Usuario> consultaCadastro() async {
    var headers = await _configuraHeaders();
    var response = await http.get(
        Uri.parse('http://localhost:3000/usuarios/consultar-usuario/'),
        headers: headers);

    if (_existeErro(response.statusCode)) {
      throw Exception(response.body);
    }

    var usuarioMap = jsonDecode(response.body);
    var usuario = Usuario(nome: '', cpf: '', telefone: '', endereco: '');
    usuario.fromMap(usuarioMap);

    return usuario;
  }

  Future alteraCadastroUsuario(
      {String? nome, String? cpf, String? telefone, String? endereco}) async {
    print("nome: $nome");
    print("cpf: $cpf");
    print("telefone: $telefone");
    print("endereco: $endereco");

    Map<String, String> body = {};
    if (nome != null) {
      if (nome.isNotEmpty) {
        body['nome'] = nome;
      }
    }

    if (cpf != null) {
      if (cpf.isNotEmpty) {
        body['cpf'] = cpf;
      }
    }
    if (telefone != null) {
      if (telefone.isNotEmpty) {
        body['telefone'] = telefone;
      }
    }
    if (endereco != null) {
      if (endereco.isNotEmpty) {
        body['endereco'] = endereco;
      }
    }

    print(body);

    var headers = await _configuraHeaders();
    var response = await http.post(
      Uri.parse('http://localhost:3000/usuarios/alterar-usuario/'),
      headers: headers,
      body: body,
    );

    if (_existeErro(response.statusCode)) {
      throw Exception(response.body);
    }
  }

  Future<Map<String, String>> _configuraHeaders() async {
    SharedPreferenceRepository? sharedPreferenceRepository =
        await SharedPreferenceRepository.getInstance();

    String token = sharedPreferenceRepository?.getToken() ?? '';

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    return headers;
  }

  bool _existeErro(int httpResponseCode) {
    if (httpResponseCode >= 400) {
      return true;
    }
    return false;
  }
}
