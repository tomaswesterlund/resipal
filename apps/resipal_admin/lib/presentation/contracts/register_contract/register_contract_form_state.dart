import 'package:equatable/equatable.dart';

class RegisterContractFormState extends Equatable {
  final String name;
  final double amount;
  final String description;
  final String period; // Fixed to "Mensual"

  const RegisterContractFormState({
    this.name = '',
    this.amount = 0.0,
    this.description = '',
    this.period = 'Mensual',
  });

  bool get canSubmit => name.isNotEmpty && amount > 0;

  int get amountInCents => (amount * 100).toInt();

  RegisterContractFormState copyWith({
    String? name,
    double? amount,
    String? description,
  }) {
    return RegisterContractFormState(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      period: this.period,
    );
  }

  @override
  List<Object?> get props => [name, amount, description, period];
}