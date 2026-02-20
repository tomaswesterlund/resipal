import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/domain/typedefs.dart';

class CreateCommunity {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  Future<CommunityId> call({
    required String userId,
    required String name,
    required String? description,
    required String? location,
    required bool isAdmin,
    required bool isSecurity,
    required bool isUser,
  }) async => _source.createCommunity(
    userId: userId,
    name: name,
    description: description,
    location: location,
    isAdmin: isAdmin,
    isSecurity: isSecurity,
    isUser: isUser,
  );
}
