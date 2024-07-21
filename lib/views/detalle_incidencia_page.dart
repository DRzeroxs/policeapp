import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/incidencia_model.dart';
import 'dart:io';

class DetalleIncidenciaPage extends StatelessWidget {
  final Incidencia incidencia;

  DetalleIncidenciaPage({required this.incidencia});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(title: Text(incidencia.titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Fecha: ${incidencia.fecha}'),
            SizedBox(height: 10),
            Text('Descripción: ${incidencia.descripcion}'),
            if (incidencia.fotoPath != null)
              Image.file(File(incidencia.fotoPath!)),
            if (incidencia.audioPath != null)
              ElevatedButton(
                onPressed: () async {
              await _audioPlayer.play(incidencia.audioPath! as Source);
            },
                child: Text('Reproducir Audio'),
              ),
          ],
        ),
      ),
    );
  }
}
