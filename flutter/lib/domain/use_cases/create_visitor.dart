import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:resipal/domain/use_cases/get_signed_in_user.dart';

class CreateVisitor {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  Future call({
    required String name,
    required String identificationPath,
  }) async {
    final user = GetSignedInUser().call();

    await _source.createVisitor(
      communityId: user.community.id,
      userId: user.id,
      name: name,
      identificationPath: identificationPath,
    );
  }
}
