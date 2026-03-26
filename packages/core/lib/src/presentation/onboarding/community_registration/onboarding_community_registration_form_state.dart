import 'package:equatable/equatable.dart';
import 'package:ui/inputs/validation/input_field.dart';

class OnboardingCommunityRegistrationFormState extends Equatable {
  final InputField<String> name;
  final InputField<String> address;
  final InputField<String> location;

  // Role Selection
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;
  final String? rolesError;

  const OnboardingCommunityRegistrationFormState({
    required this.name,
    required this.address,
    required this.location,
    this.isAdmin = true,
    this.isResident = false,
    this.isSecurity = false,
    this.rolesError,
  });

  OnboardingCommunityRegistrationFormState copyWith({
    InputField<String>? name,
    InputField<String>? address,
    InputField<String>? location,
    bool? isAdmin,
    bool? isResident,
    bool? isSecurity,
    String? rolesError,
    bool clearRolesError = false,
  }) {
    return OnboardingCommunityRegistrationFormState(
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      isAdmin: isAdmin ?? this.isAdmin,
      isResident: isResident ?? this.isResident,
      isSecurity: isSecurity ?? this.isSecurity,
      rolesError: clearRolesError ? null : (rolesError ?? this.rolesError),
    );
  }

  @override
  List<Object?> get props => [name, address, location, isAdmin, isResident, isSecurity, rolesError];

  /// Logic to validate all fields and roles
  OnboardingCommunityRegistrationFormState validate() {
    return copyWith(
      name: name.validate(),
      address: address.validate(),
      location: location.validate(),
      rolesError: areRolesValid ? null : 'Debes seleccionar al menos un rol',
    );
  }

  bool get areRolesValid => isAdmin;

  bool get isValid => name.isValid && address.isValid && location.isValid && areRolesValid;

  Map<String, dynamic> toMap() {
    return {
      'name': name.value,
      'address': address.value,
      'location': location.value,
      'roles': {'admin': isAdmin, 'resident': isResident, 'security': isSecurity},
    };
  }
}
