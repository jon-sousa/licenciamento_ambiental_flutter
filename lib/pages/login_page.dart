import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:licenciamento_ambiental/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final AuthController _controller;

  @override
  void initState() {
    super.initState();

    _controller = context.read<AuthController>();

    _controller.addListener(() {
      if (_controller.state == AuthState.success) {
        print('logado');
        Navigator.pushReplacementNamed(context, '/home');
      } else if (_controller.state == AuthState.error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Erro na autenticação'),
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
      //constraints: const BoxConstraints(maxWidth: 100),
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
                child: _formCenter(_controller),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Column _formCenter(AuthController controller) {
    final _cpfController = TextEditingController();
    final _senhaController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          controller: _cpfController,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text('CPF'),
          ),
          validator: (value) {
            return null;
          },
        ),
        TextFormField(
          controller: _senhaController,
          obscureText: true,
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
          child: const Text('Login'),
          onPressed: controller.state == AuthState.loading
              ? null
              : () async {
                  await controller.loginUsuario(
                    _cpfController.text,
                    _senhaController.text,
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
                  Navigator.of(context).pushNamed('/cadastro');
                },
                child: const Text(
                  'Não possui cadastro?',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ))),
      ],
    );
  }
}
