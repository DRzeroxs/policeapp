import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart'; // Paquete record
import 'dart:io';
import '../models/incidencia_model.dart';
import '../services/db_service.dart';

class RegistroIncidenciaPage extends StatefulWidget {
  const RegistroIncidenciaPage({Key? key}) : super(key: key);

  @override
  _RegistroIncidenciaPageState createState() => _RegistroIncidenciaPageState();
}

class _RegistroIncidenciaPageState extends State<RegistroIncidenciaPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  XFile? _foto;
  String? _audioPath;
  bool _isRecording = false;
  final Record _audioRecorder = Record();
  String? _tempAudioPath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _audioRecorder.hasPermission();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _foto = image;
    });
  }

  Future<void> _pickAudio() async {
    final PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      if (_isRecording) {
        await _stopRecording();
      } else {
        await _startRecording();
      }
    }
  }

  Future<void> _startRecording() async {
    try {
      final Directory tempDir = await Directory.systemTemp.createTemp();
      final String audioPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _audioRecorder.start(path: audioPath, encoder: AudioEncoder.AAC);
      setState(() {
        _isRecording = true;
        _tempAudioPath = audioPath;
      });
    } catch (e) {
      // Manejar errores
      print('Error al iniciar grabación: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _audioPath = _tempAudioPath;
      });
    } catch (e) {
      // Manejar errores
      print('Error al detener grabación: $e');
    }
  }

  void _saveIncidencia() async {
    if (_formKey.currentState!.validate()) {
      final incidencia = Incidencia(
        titulo: _tituloController.text,
        fecha: DateTime.now(),
        descripcion: _descripcionController.text,
        fotoPath: _foto?.path,
        audioPath: _audioPath,
      );

      await DBService().insertIncidencia(incidencia);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Incidencia')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Tomar Foto'),
              ),
              if (_isRecording) ...[
                Icon(Icons.mic, color: Colors.red, size: 48),
                ElevatedButton(
                  onPressed: _stopRecording,
                  child: const Text('Detener Grabación'),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: _pickAudio,
                  child: const Text('Grabar Audio'),
                ),
              ],
              ElevatedButton(
                onPressed: _saveIncidencia,
                child: const Text('Guardar Incidencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
