import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/visitor_data_source.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_signed_in_user.dart';
import 'package:resipal_core/src/services/session_service.dart';

class CreateVisitor {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  Future call({
    required String name,
    required String identificationPath,
  }) async {
    final user = await GetSignedInUser().call();

    await _source.createVisitor(
      communityId: _sessionService.communityId,
      userId: user.id,
      name: name,
      identificationPath: identificationPath,
    );
  }
}
