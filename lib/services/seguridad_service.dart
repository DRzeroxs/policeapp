import 'db_service.dart';

class SeguridadService {
  static Future<void> borrarRegistros() async {
    await DBService().deleteAllIncidencias();
  }
}
