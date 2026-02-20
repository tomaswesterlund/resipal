import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';

class RegisterProperty {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  Future call({
    required String communityId,
    required String residentId,
    required String contractId,
    required String name,
    required String? description,
  }) async {
    await _source.registerProperty(
      communityId: communityId,
      residentId: residentId,
      contractId: contractId,
      name: name,
    );
  }
}
