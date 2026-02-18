import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';

class FetchCommunities {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  Future call() async {
    await _source.fetchAndCacheAll();
  }
}
