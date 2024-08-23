import 'package:almas_gemelas_app/features/shared/domain/repositories/key_value_storage_repository.dart';
import 'package:almas_gemelas_app/features/shared/infrastructure/datasources/key_value_storage_datasource_impl.dart';

import '../../domain/datasources/key_value_storage_datasource.dart';

class KeyValueStorageRepositoryImpl implements KeyValueStorageRepository {
  final KeyValueStorageDatasource datasource;

  KeyValueStorageRepositoryImpl({KeyValueStorageDatasource? datasource})
      : datasource = datasource ?? KeyValueStorageDatasourceImpl();

  @override
  Future<T?> getValue<T>(String key) {
    return datasource.getValue(key);
  }

  @override
  Future<bool> removeKey(String key) {
    return datasource.removeKey(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) {
    return datasource.setKeyValue(key, value);
  }
}
