import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateApplication {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future call(CreateApplicationDto dto) async {
    // TODO: Do some validation of the DTO
    await _source.createApplication(dto);
  }
}
