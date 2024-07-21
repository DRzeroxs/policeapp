import 'package:flutter/material.dart';
import 'package:policeapp/views/registro_incidencia_page.dart';
import 'detalle_incidencia_page.dart';
import '../models/incidencia_model.dart';
import '../services/db_service.dart';

class VisualizacionIncidenciasPage extends StatefulWidget {
  const VisualizacionIncidenciasPage({Key? key}) : super(key: key);

  @override
  _VisualizacionIncidenciasPageState createState() => _VisualizacionIncidenciasPageState();
}

class _VisualizacionIncidenciasPageState extends State<VisualizacionIncidenciasPage> {
  List<Incidencia> _incidencias = [];

  @override
  void initState() {
    super.initState();
    _loadIncidencias();
  }

  Future<void> _loadIncidencias() async {
    final incidencias = await DBService().getIncidencias();
    setState(() {
      _incidencias = incidencias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incidencias')),
      body: ListView.builder(
        itemCount: _incidencias.length,
        itemBuilder: (context, index) {
          final incidencia = _incidencias[index];
          return ListTile(
            title: Text(incidencia.titulo),
            subtitle: Text(incidencia.fecha.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleIncidenciaPage(incidencia: incidencia),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistroIncidenciaPage()),
          );
          _loadIncidencias();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
