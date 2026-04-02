import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';
import 'package:ui/inputs/validation/input_field.dart';

class SendMessageFormState extends Equatable {
  final List<MemberEntity> members;
  final InputField<MemberEntity?> selectedMember;
  final InputField<String> title;
  final InputField<String> body;

  const SendMessageFormState({
    required this.members,
    required this.selectedMember,
    required this.title,
    required this.body,
  });

  SendMessageFormState copyWith({
    List<MemberEntity>? members,
    InputField<MemberEntity?>? selectedMember,
    InputField<String>? title,
    InputField<String>? body,
  }) {
    return SendMessageFormState(
      members: members ?? this.members,
      selectedMember: selectedMember ?? this.selectedMember,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [members, selectedMember, title, body];

  SendMessageFormState validate() {
    return copyWith(
      selectedMember: selectedMember.validate(),
      title: title.validate(),
      body: body.validate(),
    );
  }

  bool get isValid => selectedMember.isValid && title.isValid && body.isValid;
}
