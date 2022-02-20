import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MostrarFotoPage extends StatelessWidget {
  final Uint8List imageBytes;
  final TextEditingController _controller = TextEditingController();
  MostrarFotoPage({Key? key, required this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imagem')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controller,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            autofocus: true,
            decoration: const InputDecoration(
              label: Text('Descrição'),
            ),
          ),
        ),
        Expanded(
          child: Image.memory(imageBytes),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var documento = {_controller.text: imageBytes};
          Navigator.of(context).pop(documento);
        },
        child: const Icon(Icons.check),
        shape: const RoundedRectangleBorder(),
        backgroundColor: Colors.green,
      ),
    );
  }
}
