import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:licenciamento_ambiental/pages/mostrar_foto_page.dart';
import 'package:licenciamento_ambiental/providers/camera_repository.dart';

class CameraPage extends StatefulWidget {
  late final CameraRepository _cameraRepository;
  CameraPage({Key? key}) : super(key: key) {
    _cameraRepository = CameraRepository();
  }

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documento'),
      ),
      body: FutureBuilder(
        future: widget._cameraRepository.startCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return widget._cameraRepository.showPreview();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              await widget._cameraRepository.initializeControllerFuture;
              final image = await widget._cameraRepository.takePicture();
              var imageBytes = await image.readAsBytes();
              final documento = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MostrarFotoPage(
                    imageBytes: imageBytes,
                  ),
                ),
              );
              Navigator.of(context).pop(documento);
            } catch (error) {
              print(error);
            }
          },
          child: const Icon(
            Icons.camera_alt,
          )),
    );
  }
}
