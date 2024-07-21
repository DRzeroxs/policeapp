import 'package:flutter/material.dart';
import '../services/seguridad_service.dart';

class SeguridadPage extends StatelessWidget {
  const SeguridadPage({Key? key}) : super(key: key);

  void _confirmarBorrado(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Borrado'),
          content: const Text('¿Estás seguro de que deseas borrar todos los registros? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Borrar'),
              onPressed: () {
                SeguridadService.borrarRegistros();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Todos los registros han sido borrados.'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seguridad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () => _confirmarBorrado(context),
            child: const Text('Borrar Todos los Registros'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
