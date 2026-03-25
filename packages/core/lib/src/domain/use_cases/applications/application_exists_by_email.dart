import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class ApplicationExistsByEmail {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  bool call({required String email}) {
    final applications = _source.getByEmail(email);

    return applications.length != 0;
  }
}
