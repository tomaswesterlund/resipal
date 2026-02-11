import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/community_model.dart';
import 'package:resipal/data/sources/community_data_source.dart';
import 'package:resipal/domain/entities/community_entity.dart';

class GetCommunities {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  List<CommunityEntity> call() {
    final models = _source.getAll();

    final list = models
        .map(
          (m) => CommunityEntity(id: m.id, name: m.name, key: m.key, location: m.location, description: m.description),
        )
        .toList();

    return list;
  }
}
