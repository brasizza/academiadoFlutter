import 'package:mysql1/mysql1.dart';

import 'Constantes.dart';

class QueryBuilder {
  var conn;
  static Future<MySqlConnection> getConnection() async {
    var conn = await MySqlConnection.connect(ConnectionSettings(host: db_hostname, port: db_port, user: db_username, password: db_password, db: db_dbname));
    return conn;
  }

  static Future<void> closeConnection(MySqlConnection conn) async {
    await conn.close();
  }

  static void createDatabase(MySqlConnection _conn, String estruturaBanco) async {
    var _conn = await getConnection();
    await _conn.query(estruturaBanco);
  }

  static void clear(MySqlConnection _conn, dynamic instance) async {
    var _tableName = QueryBuilder().discoverTableName(instance.runtimeType.toString());
    var sql = ' TRUNCATE  ${_tableName} ';
    await _conn.query(sql);
  }

  Future<dynamic> create(MySqlConnection _conn, [dynamic model]) async {
    var _dados = (model.toMap()) as Map<String, dynamic>;
    var _tableName = discoverTableName(model.runtimeType.toString());
    var _keys = (_dados.keys.join(','));
    var _valuesObject = <dynamic>[];
    _dados.values.forEach((val) => _valuesObject.add(val));
    var _genWillcard = List.generate(_dados.length, (index) => '?').join(',');
    var sql = ' Insert into ${_tableName} (${_keys})  VALUES (${_genWillcard})';
    var result = await _conn.query(sql, _valuesObject);
    try {
      model.id = result.insertId;
    } catch (e) {
      throw Exception('Nenhum campo ID encontrado');
    }
    return model;
  }

  String discoverTableName(String table) {
    var tableName = table.toLowerCase();
    switch (tableName.substring(tableName.length - 1, tableName.length)) {
      case 's':
        tableName += 'es';
        break;
      default:
        tableName += 's';
        break;
    }
    return tableName;
  }
}
