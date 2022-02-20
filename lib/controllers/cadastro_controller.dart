import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/models/usuario.dart';
import 'package:licenciamento_ambiental/providers/cadastro_repository.dart';

enum CadastroState { idle, error, success, loading }

class CadastroController extends ChangeNotifier {
  var state = CadastroState.idle;
  final _cadastroRepository = CadastroRepository();

  Future<Usuario> consultaUsuario() async {
    var usuario = await _cadastroRepository.consultaCadastro();
    return usuario;
  }

  Future alteraCadastroUsuario(
      {String? nome, String? cpf, String? telefone, String? endereco}) async {
    await _cadastroRepository.alteraCadastroUsuario(
        nome: nome, cpf: cpf, telefone: telefone, endereco: endereco);
  }
}
