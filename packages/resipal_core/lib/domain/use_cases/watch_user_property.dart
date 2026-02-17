// import 'package:get_it/get_it.dart';
// import 'package:resipal_core/core/services/logger_service.dart';
// import 'package:resipal_core/domain/entities/user_property_entity.dart';
// import 'package:resipal_core/domain/refs/community_ref.dart';
// import 'package:resipal_core/domain/refs/user_ref.dart';
// import 'package:resipal_core/domain/repositories/community_repository.dart';
// import 'package:resipal_core/domain/repositories/maintenance_repository.dart';
// import 'package:resipal_core/domain/repositories/property_repository.dart';
// import 'package:resipal_core/domain/repositories/user_repository.dart';
// import 'package:rxdart/rxdart.dart';

// class WatchUserProperty {
//   final LoggerService _logger = GetIt.I<LoggerService>();
//   final CommunityRepository _communityRepository = GetIt.I<CommunityRepository>();
//   final MaintenanceRepository _maintenanceRepository = GetIt.I<MaintenanceRepository>();
//   final PropertyRepository _propertyRepository = GetIt.I<PropertyRepository>();
//   final UserRepository _userRepository = GetIt.I<UserRepository>();

//   Stream<UserPropertyEntity> call(String propertyId) {
//     try {
//       final property = _propertyRepository.getPropertyById(propertyId);

//       if (property.ownerId == null) {
//         _logger.logException(
//           exception: 'Property does not have an owner.',
//           featureArea: 'WatchUserProperty',
//           stackTrace: null,
//           metadata: {'propertyId': propertyId},
//         );
//         throw Exception('WatchUserProperty: Property does not have an owner.');
//       }

//       if (property.contractId == null) {
//         _logger.logException(
//           exception: 'Property does not have a contract.',
//           featureArea: 'WatchUserProperty',
//           stackTrace: null,
//           metadata: {'propertyId': propertyId},
//         );
//         throw Exception('WatchUserProperty: Property does not have an owner.');
//       }

//       return CombineLatestStream.combine4(
//         _communityRepository.watchById(property.communityId),
//         _maintenanceRepository.watchMaintenanceContractById(property.contractId!),
//         _propertyRepository.watchById(property.id),
//         _userRepository.watchById(property.ownerId!),

//         (community, contract, property, user) {
//           final entity = UserPropertyEntity(
//             id: property.id,
//             community: CommunityRef(id: community.id, name: community.name),
//             owner: UserRef(id: user.id, name: user.name),
//             createdAt: property.createdAt,
//             name: property.name,
//             description: property.description,
//             contract: contract,
//           );

//           return entity;
//         },
//       );
//     } catch (e, s) {
//       _logger.logException(
//         exception: e,
//         featureArea: 'WatchUserProperty',
//         stackTrace: s,
//         metadata: {'propertyId': propertyId},
//       );
//       rethrow;
//     }
//   }
// }
