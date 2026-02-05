import 'package:equatable/equatable.dart';
import 'package:resipal/core/string_extensions.dart';

class UserOnboardingFormState extends Equatable {
  final String? name;
  final String? phoneNumber;
  final String? emergencyPhoneNumber;
  final String? email;

  const UserOnboardingFormState({
    this.name,
    this.phoneNumber,
    this.emergencyPhoneNumber,
    this.email,
  });

  UserOnboardingFormState copyWith({
    String? name,
    String? phoneNumber,
    String? emergencyPhoneNumber,
    String? email,
  }) {
    return UserOnboardingFormState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber ?? this.emergencyPhoneNumber,
      email: email ?? this.email,
    );
  }

  bool isValid() {
    return name.isNotNullOrEmpty &&
        phoneNumber.isNotNullOrEmpty &&
        emergencyPhoneNumber.isNotNullOrEmpty &&
        email.isNotNullOrEmpty;
  }
  
  @override
  List<Object?> get props => [name, phoneNumber, emergencyPhoneNumber, email];
}
