import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/ledger_entity.dart';

class UserLedgerState extends Equatable {
  final bool isFetching;
  final LedgerEntity? ledger;
  final String? errorMessage;
  final Object? exception;

  bool get isError => errorMessage != null || exception != null;

  const UserLedgerState({
    this.isFetching = true,
    this.ledger,
    this.errorMessage,
    this.exception,
  });

  UserLedgerState copyWith({
    bool? isFetching,
    LedgerEntity? ledger,
    String? errorMessage,
    Exception? exception,
  }) {
    return UserLedgerState(
      isFetching: isFetching ?? this.isFetching,
      ledger: ledger ?? this.ledger,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [isFetching, ledger, errorMessage, exception];
}
