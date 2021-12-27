import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/controllers/solicitacao_controller.dart';
import 'package:licenciamento_ambiental/models/solicitacao.dart';
import 'package:provider/src/provider.dart';

class CriarSolicitacao extends StatefulWidget {
  CriarSolicitacao({Key? key}) : super(key: key);

  @override
  _CriarSolicitacaoState createState() => _CriarSolicitacaoState();
}

class _CriarSolicitacaoState extends State<CriarSolicitacao> {
  late SolicitacaoController _controller;
  final TextEditingController _imovelController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = context.read<SolicitacaoController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Solicitação'),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _imovelController,
                decoration: const InputDecoration(
                  label: Text('Endereço'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                title: Text('Adicionar Documento'),
                leading: Icon(Icons.camera_alt),
                onTap: null,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _cadastrarSolicitacao,
              child: const Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }

  _cadastrarSolicitacao() {
    var imovel = _imovelController.text;
    print(imovel);
    try {
      _controller
          .cadastrarSolicitacao(imovel)
          .then((_) => print('Solicitacao cadastrada'));
    } catch (error) {
      print(error);
    }
  }
}
