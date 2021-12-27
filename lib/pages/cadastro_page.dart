import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class Cadastro extends StatefulWidget {
  Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  late final AuthController _controller;

  final _nomeController = TextEditingController();

  final _cpfController = TextEditingController();

  final _enderecoController = TextEditingController();

  final _telefoneController = TextEditingController();

  final _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = context.read<AuthController>();

    _controller.addListener(() {
      if (_controller.state == AuthState.success) {
        Navigator.pop(context);
      } else if (_controller.state == AuthState.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Erro na autenticação: ${_controller.erroDeAuthenticacao}'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Placeholder(
                  fallbackHeight: 50,
                  fallbackWidth: 100,
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        label: Text('Nome'),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _cpfController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        label: Text('CPF'),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _enderecoController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        label: Text('Endereço'),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _telefoneController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        label: Text('Telefone'),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _senhaController,
                      decoration: const InputDecoration(
                        label: Text('Senha'),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      child: const Text('Cadastrar'),
                      onPressed: () async {
                        await _controller.cadastroUsuario(
                          nome: _nomeController.text,
                          cpf: _cpfController.text,
                          telefone: _telefoneController.text,
                          endereco: _enderecoController.text,
                          senha: _senhaController.text,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'já possui cadastro?',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
