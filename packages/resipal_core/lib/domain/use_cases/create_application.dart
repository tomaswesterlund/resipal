import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/application_data_source.dart';

class CreateApplication {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future call({required String communityId, required String userId}) async =>
      _source.createApplication(communityId: communityId, userId: userId);
}
