import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import '../models/Pais.dart';
import '../commons/Constantes.dart';

class EstadoRepository {
  Future<List<dynamic>> pegarEstados(Dio dio, Pais pais) async {
    var estadosDio = await dio.get(estadoApi(pais.sigla));
    if (estadosDio.statusCode != 200) {
      return null;
    }
    return estadosDio.data;
  }

  String estadoApi(String sigla) {
    try {
      return baseAPI[sigla.toUpperCase()]['estado'];
    } catch (e) {
      throw Exception('Pais ${sigla} nao implementado');
    }
  }
}
