import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetOptionalInvitationByQrCodeToken {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  Future<InvitationEntity?> call({required String qrCodeToken}) async {
    final model = _source.getOptionalByQrCodeToken(qrCodeToken);
    if(model == null) return null;
    
    final entity = GetInvitationById().call(model.id);
    return entity;
  }
}