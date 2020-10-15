import 'package:dio/dio.dart';
import '../models/cidade.dart';
import '../commons/constantes.dart';

class CidadeRepository {
  Future<List<dynamic>> pegarCidades(Dio dio, String siglaPais, String siglaEstado) async {
    var cidadesDio = await dio.get(cidadeAPI(siglaPais, siglaEstado));
    if (cidadesDio.statusCode != 200) {
      return null;
    }
    return cidadesDio.data;
  }

  String cidadeAPI(String siglaPais, String siglaEstado) {
    try {
      return baseAPI[siglaPais.toUpperCase()]['cidade'].replaceAll('%sigla%', siglaEstado);
    } catch (e) {
      throw Exception('Pais ${siglaPais} nao implementado');
    }
  }
}
