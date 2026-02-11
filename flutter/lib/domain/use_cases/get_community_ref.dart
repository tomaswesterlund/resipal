import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/community_model.dart';
import 'package:resipal/data/sources/community_data_source.dart';
import 'package:resipal/domain/refs/community_ref.dart';

class GetCommunityRef {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityRef fromId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Community $id not found in cache. Ensure the stream is active.');
    }

    return fromModel(model);
  }

  CommunityRef fromModel(CommunityModel model) => CommunityRef(id: model.id, name: model.name);
}
