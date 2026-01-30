import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';

class UserActiveInvitationsState extends Equatable {
  final bool isFetching;
  final List<InvitationEntity> invitations;
  final String? errorMessage;
  final Object? exception;

  bool get isError => errorMessage != null || exception != null;

  const UserActiveInvitationsState({this.isFetching = true, this.invitations = const [], this.errorMessage, this.exception});

  UserActiveInvitationsState copyWith({bool? isFetching, List<InvitationEntity>? invitations, String? errorMessage, Exception? exception}) {
    return UserActiveInvitationsState(
      isFetching: isFetching ?? this.isFetching,
      invitations: invitations ?? this.invitations,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [isFetching, invitations, errorMessage, exception];
}
