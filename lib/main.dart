import 'package:flutter/material.dart';
import 'views/acerca_de_page.dart';
import 'views/visualizacion_incidencias_page.dart';
import 'views/registro_incidencia_page.dart';
import 'views/seguridad_page.dart';
import 'models/oficial_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final Oficial oficial = const Oficial(
    nombre: 'Miguel',
    apellido: 'Grullon Reinoso',
    matricula: '2022-0111',
    fotoUrl: 'lib/assets/perfil.jpg',
    reflexion: 'La seguridad de estar cerca',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Incidencias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(oficial: oficial),
    );
  }
}

class HomePage extends StatelessWidget {
  final Oficial oficial;

  const HomePage({Key? key, required this.oficial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App de Incidencias')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VisualizacionIncidenciasPage()),
                );
              },
              child: const Text('Visualizar Incidencias'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistroIncidenciaPage()),
                );
              },
              child: const Text('Registrar Incidencia'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcercaDePage(oficial: oficial)),
                );
              },
              child: const Text('Acerca de'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SeguridadPage()),
                );
              },
              child: const Text('Seguridad'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
