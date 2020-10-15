import 'dart:io';

import 'package:dio/dio.dart';
import 'commons/QueryBuilder.dart';
import 'commons/dioInterceptor.dart';
import 'models/cidade.dart';
import 'models/estado.dart';
import 'models/pais.dart';
import 'repository/cidadeRepository.dart';
import 'repository/estadoRepository.dart';

void main(List<String> arguments) async {
  var conn = await QueryBuilder.getConnection();
  Pais.initDatabase(conn);
  Estado.initDatabase(conn);
  Cidade.initDatabase(conn);
  await QueryBuilder.clear(conn, Pais());
  await QueryBuilder.clear(conn, Cidade());
  await QueryBuilder.clear(conn, Estado());
  var pais = await Pais(pais: 'Brasil', sigla: 'BR').create(conn);

  var dio = Dio();
  dio.interceptors.add(DioInterceptor());
  print('Pegando os estados do link do IBGE');
  var estados = await EstadoRepository().pegarEstados(dio, pais);

  await Future.forEach(estados, (estMap) async {
    estMap['pais'] = pais.id;
    Estado estado = await Estado.fromMap(estMap).create(conn);
    var cidades = await CidadeRepository().pegarCidades(dio, pais.sigla, estado.sigla);
    await Future.forEach(cidades, (cidMap) async {
      cidMap['estado'] = estado.id;
      Cidade cidade = await Cidade.fromMap(cidMap).create(conn);
    });
  }).whenComplete(() async {
    await QueryBuilder.closeConnection(conn);
    exit(0);
  });
}
