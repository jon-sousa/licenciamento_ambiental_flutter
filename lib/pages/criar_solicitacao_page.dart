import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/controllers/solicitacao_controller.dart';
import 'package:licenciamento_ambiental/models/solicitacao.dart';
import 'package:licenciamento_ambiental/pages/camera_page.dart';
import 'package:provider/src/provider.dart';

class CriarSolicitacao extends StatefulWidget {
  const CriarSolicitacao({Key? key}) : super(key: key);

  @override
  _CriarSolicitacaoState createState() => _CriarSolicitacaoState();
}

class _CriarSolicitacaoState extends State<CriarSolicitacao> {
  List<Map<String, Uint8List>> documentos = [];
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
            Card(
              child: ListTile(
                title: const Text('Adicionar Documento'),
                leading: const Icon(Icons.camera_alt),
                onTap: () => _adicionarDocumento(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async => await _cadastrarSolicitacao(),
              child: const Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }

  _cadastrarSolicitacao() {
    var imovel = _imovelController.text;
    Map<String, dynamic> responseMap = {'imovel': imovel};
    responseMap.addAll({'files': documentos});
    try {
      _controller
          .cadastrarSolicitacao(responseMap)
          .then((_) => print('Solicitacao cadastrada'));
    } catch (error) {
      print(error);
    }
  }

  _adicionarDocumento() async {
    Map<String, Uint8List> documento =
        await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CameraPage(),
      fullscreenDialog: true,
    ));

    documentos.add(documento);
  }
}
