import 'dart:convert';
import 'package:mysql1/mysql1.dart';
import '../commons/QueryBuilder.dart';

class Estado extends QueryBuilder {
  int id;
  String sigla;
  String estado;
  int pais;

  Estado({
    this.id,
    this.sigla,
    this.estado,
    this.pais,
  });

  static const estruturaBanco = ''' create table if not exists
  `estados` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(255) NULL,
  `sigla` CHAR(10) NULL,
  `pais` BIGINT NULL,
  PRIMARY KEY (`id`))''';

  static void initDatabase(MySqlConnection conn) async => await QueryBuilder.createDatabase(conn, estruturaBanco);

  @override
  Future<dynamic> create(conn, [dynamic dados]) async {
    await super.create(conn, this);
    return this;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sigla': sigla,
      'estado': estado,
      'pais': pais,
    };
  }

  factory Estado.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Estado(
      id: map['id'],
      sigla: map['sigla'],
      estado: map['nome'],
      pais: map['pais'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Estado.fromJson(String source) => Estado.fromMap(json.decode(source));
}
