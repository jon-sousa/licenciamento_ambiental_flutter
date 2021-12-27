import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/controllers/auth_controller.dart';
import 'package:licenciamento_ambiental/controllers/cadastro_controller.dart';
import 'package:licenciamento_ambiental/controllers/solicitacao_controller.dart';
import 'package:licenciamento_ambiental/pages/cadastro_page.dart';
import 'package:licenciamento_ambiental/pages/home_page.dart';
import 'package:licenciamento_ambiental/pages/login_page.dart';
import 'package:licenciamento_ambiental/providers/shared_preference_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (_) => AuthController(),
        ),
        ChangeNotifierProvider<CadastroController>(
          create: (_) => CadastroController(),
        ),
        ChangeNotifierProvider<SolicitacaoController>(
          create: (_) => SolicitacaoController(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/login',
          routes: {
            '/home': (context) => HomePage(),
            '/login': (context) => LoginForm(),
            '/cadastro': (context) => Cadastro(),
          }),
    );
  }
}
