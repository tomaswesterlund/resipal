import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:resipal_core/domain/use_cases/get_signed_in_user.dart';
import 'package:resipal_core/services/session_service.dart';

class CreateVisitor {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  Future call({
    required String name,
    required String identificationPath,
  }) async {
    final user = await GetSignedInUser().call();

    await _source.createVisitor(
      communityId: _sessionService.selectedCommunityId,
      userId: user.id,
      name: name,
      identificationPath: identificationPath,
    );
  }
}
