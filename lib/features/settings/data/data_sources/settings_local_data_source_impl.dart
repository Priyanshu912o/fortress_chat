import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import 'settings_local_data_source.dart';

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final AppDatabase _db;
  SettingsLocalDataSourceImpl(this._db);

  @override
  Future<void> clearLocalDatabase() async {
    await _db.clearAllData();
  }
}
