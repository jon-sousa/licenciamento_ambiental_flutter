import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/components/card_solicitacao.dart';
import 'package:licenciamento_ambiental/controllers/solicitacao_controller.dart';
import 'package:licenciamento_ambiental/models/solicitacao.dart';
import 'package:licenciamento_ambiental/pages/alterar_cadastro_page.dart';
import 'package:licenciamento_ambiental/pages/criar_solicitacao_page.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SolicitacaoController _controller;
  late Future solicitacoesFuture;

  @override
  void initState() {
    super.initState();

    _controller = context.read<SolicitacaoController>();
    solicitacoesFuture = _controller.consultarSolicitacoes();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Solicitações'),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AlterarCadastro(),
                  fullscreenDialog: true,
                ));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.person),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8, right: 16),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 24),
              child: FutureBuilder(
                future: solicitacoesFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print('requisitando ao backend');
                  Widget result;
                  if (snapshot.hasData) {
                    result = buildBody(snapshot.data, context);
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
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CriarSolicitacao(),
                      fullscreenDialog: true,
                    ));
                  },
                ),
              ),
            ),
          ],
        ));
  }

  Column buildBody(List<Solicitacao> solicitacoes, BuildContext context) {
    List<Widget> solicitacoesCard = [];
    for (var solicitacao in solicitacoes) {
      solicitacoesCard.add(
        CardSolicitacao(solicitacao),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ...solicitacoesCard,
      ],
    );
  }
}
