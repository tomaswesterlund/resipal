import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/community_data_source.dart';
import 'package:resipal_core/src/domain/typedefs.dart';

class CreateCommunity {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  Future<CommunityId> call({required String name, required String? description, required String location}) async {
    final CommunityId communityId = await _source.createCommunity(
      name: name,
      description: description,
      location: location,
    );

    return communityId;
  }
}
