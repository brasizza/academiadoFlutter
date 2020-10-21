import 'dart:convert';

import 'package:mysql1/mysql1.dart';

import '../commons/QueryBuilder.dart';

class Pais extends QueryBuilder {
  int id;
  String pais;
  String sigla;

  Pais({
    this.id,
    this.pais,
    this.sigla,
  });

  static const estruturaBanco = '''create table if not exists `paises` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `pais` VARCHAR(45) NULL,
  `sigla` CHAR(10) NULL,
  PRIMARY KEY (`id`))''';

  static void initDatabase() async => await QueryBuilder.createDatabase(estruturaBanco);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pais': pais,
      'sigla': sigla,
    };
  }

  factory Pais.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Pais(
      id: map['id'],
      pais: map['pais'],
      sigla: map['sigla'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Pais.fromJson(String source) => Pais.fromMap(json.decode(source));

  @override
  Future<dynamic> create([dynamic dados]) async {
    await super.create(this);
    return this;
  }

  @override
  Future<void> clear([dynamic model]) async {
    await super.clear(this);
  }
}
