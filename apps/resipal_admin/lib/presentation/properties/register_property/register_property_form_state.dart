import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_core/domain/entities/contract_entity.dart';
import 'package:resipal_core/domain/refs/user_ref.dart';

class RegisterPropertyFormState extends Equatable {
  final List<UserRef> residents;
  final List<ContractEntity> contracts;

  final UserRef? resident;
  final ContractEntity? contract;
  final String? name;
  final String? description;

  bool get canSubmit {
    if (contract == null) return false;
    if (name == null) return false;
    return true;
  }

  const RegisterPropertyFormState({
    required this.contracts,
    required this.residents,
    this.contract,
    this.resident,
    this.name,
    this.description
  });

  RegisterPropertyFormState copyWith({
    ContractEntity? contract,
    UserRef? resident,

    String? name,
    String? description,
    XFile? receiptImage,
  }) {
    return RegisterPropertyFormState(
      contracts: contracts,
      residents: residents,
      contract: contract ?? this.contract,
      resident: resident ?? this.resident,
      name: name ?? this.name,
      description: description ?? this.description
    );
  }

    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'residents': residents.map((x) => x.toMap()).toList(),
      'contracts': contracts.map((x) => x.toMap()).toList(),
      'resident': resident?.toMap(),
      'contract': contract?.toMap(),
      'name': name,
      'description': description,
    };
  }


  @override
  String toString() {
    return 'RegisterPropertyFormState(resident: $resident, contract: $contract, name: $name, description: $description)';
  }

  @override
  List<Object?> get props => [residents, contracts, resident, contract, name, description];
}
