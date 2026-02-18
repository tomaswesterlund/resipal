import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/domain/entities/community/community_entity.dart';
import 'package:resipal_core/domain/use_cases/get_community.dart';

class GetCommunities {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  Future<List<CommunityEntity>> call() async {
    final models = _source.getAll();
    final list = models.map((m) => GetCommunity().call(m.id)).toList();
    return list;
  }
}
