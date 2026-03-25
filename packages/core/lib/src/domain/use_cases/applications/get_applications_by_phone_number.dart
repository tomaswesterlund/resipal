import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class GetApplicationsByPhoneNumber {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();
  final GetApplicationById _getApplicationById = GetApplicationById();

  List<ApplicationEntity> call({required String phoneNumber}) {
    final models = _source.getByPhoneNumber(phoneNumber);
    return models.map((x) => _getApplicationById.call(id: x.id)).toList();
  }
}
