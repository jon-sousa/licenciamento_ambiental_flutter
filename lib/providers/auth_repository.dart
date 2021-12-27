import 'package:http/http.dart' as http;
import 'package:licenciamento_ambiental/models/usuario.dart';

class AuthRepository {
  Future<String> loginUsuario(cpf, senha) async {
    var response = await http.post(
        Uri.parse('http://localhost:3000/usuarios/login/'),
        body: {'cpf': cpf, 'senha': senha});

    if (_existeErro(response.statusCode)) {
      throw Exception('erro: ${response.body}');
    }

    if (response.headers['authorization'] == null) {
      throw Exception('Erro na requisicao');
    }

    return response.headers['authorization'].toString();
  }

  Future cadastroUsuario(Usuario usuario) async {
    var response = await http.post(
      Uri.parse('http://localhost:3000/usuarios/cadastrar-usuario'),
      body: usuario.toMap(),
    );

    if (_existeErro(response.statusCode)) {
      throw Exception('erro: ${response.body}');
    }

    var errosUsuario = _validaUsuario(usuario);
    if (errosUsuario.isNotEmpty) {
      throw Exception(errosUsuario);
    }
  }

  bool _existeErro(int httpResponseCode) {
    if (httpResponseCode >= 400) {
      return true;
    }
    return false;
  }

  List<String> _validaUsuario(Usuario usuario) {
    List<String> erros = [];

    if (usuario.nome == '') {
      erros.add('Nome não foi informado');
    }

    if (usuario.nome == '') {
      erros.add('Nome não foi informado');
    }

    if (usuario.cpf == '') {
      erros.add('CPF não foi informado');
    }

    if (usuario.telefone == '') {
      erros.add('Telefone não foi informado');
    }

    if (usuario.endereco == '') {
      erros.add('Endereço não foi informado');
    }

    if (usuario.senha == '') {
      erros.add('Senha não foi informado');
    }

    return erros;
  }
}
