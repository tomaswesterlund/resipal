import 'package:get_it/get_it.dart';
import 'package:core/src/data/models/community/upsert_community_model.dart';
import 'package:core/src/data/sources/community_data_source.dart';
import 'package:core/src/domain/typedefs.dart';

class CreateCommunity {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  Future<CommunityId> call({required String name, required String? description, required String location}) async {
    final model = UpsertCommunityModel(name: name, location: location, description: description);
    return await _source.upsert(model);
  }
}
