import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/visitor_data_source.dart';

class RegisterVisitor {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  Future call({
    required String communityId,
    required String userId,
    required String name,
    required String identificationImagePath,
  }) async {
    await _source.upsert(
      communityId: communityId,
      userId: userId,
      name: name,
      identificationImagePath: identificationImagePath,
    );
  }
}
