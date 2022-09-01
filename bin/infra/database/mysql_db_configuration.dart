import 'package:mysql1/mysql1.dart';

import '../../util/custom_env.dart';
import 'db_configuration.dart';

class MySqlDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;
  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception('[ERROR/DB] -> Failed Crate Connection');
    }
    return _connection!;
  }

  @override
  Future createConnection() async => await MySqlConnection.connect(
        ConnectionSettings(
          host: await CustomEnv.get<String>(key: 'db_host'),
          port: await CustomEnv.get<int>(key: 'db_port'),
          user: await CustomEnv.get<String>(key: 'db_user'),
          password: await CustomEnv.get<String>(key: 'db_password'),
          db: await CustomEnv.get<String>(key: 'db_schema'),
        ),
      );
}
