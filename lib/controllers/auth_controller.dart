import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/models/usuario.dart';
import 'package:licenciamento_ambiental/providers/auth_repository.dart';
import 'package:licenciamento_ambiental/providers/shared_preference_repository.dart';

enum AuthState { idle, error, success, loading }

class AuthController extends ChangeNotifier {
  final _authRepository = AuthRepository();
  var state = AuthState.idle;
  String erroDeAuthenticacao = '';

  loginUsuario(String cpf, String senha) async {
    try {
      state = AuthState.loading;
      notifyListeners();

      var token = await _authRepository.loginUsuario(cpf, senha);
      state = AuthState.success;

      var prefRepository = await SharedPreferenceRepository.getInstance();

      if (prefRepository == null) {
        throw Exception(
            'Erro ao criar instancia de SharedPreferenceRepository');
      }
      prefRepository.setToken(token);
      notifyListeners();
    } catch (error) {
      state = AuthState.error;
      notifyListeners();
      return 'Erro no login';
    }
  }

  cadastroUsuario(
      {required String nome,
      required String cpf,
      required String telefone,
      required String endereco,
      required String senha}) async {
    try {
      state = AuthState.loading;
      notifyListeners();

      var usuario = Usuario(
          nome: nome,
          cpf: cpf,
          telefone: telefone,
          endereco: endereco,
          senha: senha);

      await _authRepository.cadastroUsuario(usuario);
      state = AuthState.success;
      notifyListeners();
    } catch (error) {
      state = AuthState.error;
      erroDeAuthenticacao = error.toString();
      notifyListeners();
    }
  }
}
