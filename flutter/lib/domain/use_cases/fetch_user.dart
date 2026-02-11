import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/user_data_source.dart';

class FetchUser {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future call(String id) => _source.fetchById(id);
}