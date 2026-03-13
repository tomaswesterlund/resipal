import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetVisitorsByCommunityIdAndUserId {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();
  final GetVisitor _getVisitor = GetVisitor();

  List<VisitorEntity> call({required String communityId, required String userId}) {
    final visitors = _source.getByCommunityIdAndUserId(communityId: communityId, userId: userId);
    return visitors.map((x) => _getVisitor.fromModel(x)).toList();

  }
}