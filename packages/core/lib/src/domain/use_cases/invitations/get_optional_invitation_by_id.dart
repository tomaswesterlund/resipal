import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class GetOptionalInvitationById {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  Future<InvitationEntity?> call({required String id}) async {
    final model = _source.getOptionalById(id);
    if(model == null) return null;
    
    final entity = GetInvitationById().call(id);
    return entity;
  }
}