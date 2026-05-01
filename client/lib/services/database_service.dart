import 'package:postgres/postgres.dart';

class DatabaseService {
  static Connection? _connection;
  
  // Local PostgreSQL connection
  static const String host = 'localhost';
  static const int port = 5432;
  static const String database = 'fsc_portal';
  static const String username = 'postgres';
  static const String password = 'postgres';

  // Connect to local database
  static Future<Connection> getConnection() async {
    if (_connection != null) return _connection!;

    _connection = await Connection.open(
      Endpoint(
        host: host,
        port: port,
        database: database,
        username: username,
        password: password,
      ),
      settings: const ConnectionSettings(
        sslMode: SslMode.disable,
      ),
    );

    return _connection!;
  }

  // Execute query
  static Future<Result> query(String sql, [List<dynamic>? params]) async {
    final conn = await getConnection();
    return await conn.execute(sql, parameters: params);
  }

  // Close connection
  static Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
