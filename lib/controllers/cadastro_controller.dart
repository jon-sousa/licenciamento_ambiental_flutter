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
}
