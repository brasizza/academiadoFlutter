import 'dart:convert';

import 'package:mysql1/mysql1.dart';

import '../commons/QueryBuilder.dart';

class Cidade extends QueryBuilder {
  int id;
  int estado;
  String cidade;
  Cidade({
    this.id,
    this.estado,
    this.cidade,
  });

  @override
  Future<dynamic> create(conn, [dynamic dados]) async {
    await super.create(conn, this);
    return this;
  }

  static const estruturaBanco = ''' create table if not exists
  `cidades` (
  `id` BIGINT NOT NULL,
  `cidade` VARCHAR(255) NULL,
  `estado` BIGINT NULL,
  PRIMARY KEY (`id`));''';

  static void initDatabase(MySqlConnection conn) async => await QueryBuilder.createDatabase(conn, estruturaBanco);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estado': estado,
      'cidade': cidade,
    };
  }

  factory Cidade.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cidade(
      id: map['id'],
      estado: map['estado'],
      cidade: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cidade.fromJson(String source) => Cidade.fromMap(json.decode(source));
}
