import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class UpdateFirebaseCloudMessagingToken {
  final UserDataSource _source = GetIt.I<UserDataSource>();
  Future call({required String fcmToken}) async {
    final user = GetSignedInUser().call();
    await _source.updateFirebaseCloudMessagingToken(userId: user.id, fcmToken: fcmToken);
  }
}