import 'dart:io';

import 'package:dio/dio.dart';
import 'commons/QueryBuilder.dart';
import 'commons/DioInterceptor.dart';
import 'models/Cidade.dart';
import 'models/Estado.dart';
import 'models/Pais.dart';
import 'repository/CidadeRepository.dart';
import 'repository/EstadoRepository.dart';

void main(List<String> arguments) async {
  await Pais.initDatabase();
  await Estado.initDatabase();
  await Cidade.initDatabase();
  await Pais().clear().then((_) async => Cidade().clear()).then((_) async => Estado().clear());
  var pais = await Pais(pais: 'Brasil', sigla: 'BR').create();
  var dio = Dio();
  dio.interceptors.add(DioInterceptor());
  var estados = await EstadoRepository().pegarEstados(dio, pais);
  await Future.forEach(estados, (estMap) async {
    estMap['pais'] = pais.id;
    Estado estado = await Estado.fromMap(estMap).create();
    var cidades = await CidadeRepository().pegarCidades(dio, pais.sigla, estado.sigla);
    await Future.forEach(cidades, (cidMap) async {
      cidMap['estado'] = estado.id;
      await Cidade.fromMap(cidMap).create();
    });
  });
}
