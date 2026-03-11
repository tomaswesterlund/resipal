import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/property_data_source.dart';
import 'package:resipal_core/src/domain/typedefs.dart';

class RegisterProperty {
  final PropertyDataSource _source = GetIt.I<PropertyDataSource>();
  
  Future<PropertyId> call({
    required String communityId,
    required String residentId,
    required String contractId,
    required String name,
    required String? description,
  }) async => await _source.registerProperty(
    communityId: communityId,
    residentId: residentId,
    contractId: contractId,
    name: name,
  );
}
