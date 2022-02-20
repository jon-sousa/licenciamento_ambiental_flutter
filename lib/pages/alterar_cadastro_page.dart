import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/controllers/auth_controller.dart';
import 'package:licenciamento_ambiental/controllers/cadastro_controller.dart';
import 'package:licenciamento_ambiental/models/usuario.dart';
import 'package:provider/src/provider.dart';

class AlterarCadastro extends StatefulWidget {
  AlterarCadastro({Key? key}) : super(key: key);

  @override
  _AlterarCadastroState createState() => _AlterarCadastroState();
}

class _AlterarCadastroState extends State<AlterarCadastro> {
  final _formKey = GlobalKey<FormState>();

  late final CadastroController _controller;

  final _nomeController = TextEditingController();

  final _cpfController = TextEditingController();

  final _enderecoController = TextEditingController();

  final _telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = context.read<CadastroController>();

    _controller.addListener(() {
      if (_controller.state == CadastroState.success) {
        Navigator.pop(context);
      } else if (_controller.state == CadastroState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao alterar cadastro.'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Alterar Cadastro'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: _controller.consultaUsuario(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget result;
              if (snapshot.hasData) {
                result = _buildForm(snapshot.data);
              } else if (snapshot.hasError) {
                result = const Center(
                  child: Text('Erro'),
                );
              } else {
                result = const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                );
              }
              return result;
            },
          ),
        ));
  }

  Form _buildForm(Usuario usuario) {
    _nomeController.text = usuario.nome;
    _cpfController.text = usuario.cpf;
    _enderecoController.text = usuario.endereco;
    _telefoneController.text = usuario.telefone;

    return Form(
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
            Column(
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
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  child: const Text('Confirmar'),
                  onPressed: () async {
                    await _controller.alteraCadastroUsuario(
                      nome: _nomeController.text,
                      cpf: _cpfController.text,
                      telefone: _telefoneController.text,
                      endereco: _enderecoController.text,
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
