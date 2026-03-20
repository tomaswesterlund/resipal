import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class ApplicationExistsByEmail {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  bool call({required String email}) {
    final model = _source.getOptionalByEmail(email);
    return model != null;
  }
}
