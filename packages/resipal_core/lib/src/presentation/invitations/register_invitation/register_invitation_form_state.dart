import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/ui/inputs/validation/input_field.dart';

class RegisterInvitationFormState extends Equatable {
  final List<PropertyEntity> properties;
  final List<VisitorEntity> visitors;

  final InputField<PropertyEntity?> property;
  final InputField<VisitorEntity?> visitor;
  final InputField<DateTimeRange?> dateRange;
  final InputField<int?> maxEntries;

  const RegisterInvitationFormState({
    required this.properties,
    required this.visitors,
    required this.property,
    required this.visitor,
    required this.dateRange,
    required this.maxEntries,
  });

  RegisterInvitationFormState copyWith({
    List<PropertyEntity>? properties,
    List<VisitorEntity>? visitors,
    InputField<PropertyEntity?>? property,
    InputField<VisitorEntity?>? visitor,
    InputField<DateTimeRange?>? dateRange,
    InputField<int?>? maxEntries,
  }) {
    return RegisterInvitationFormState(
      properties: properties ?? this.properties,
      visitors: visitors ?? this.visitors,
      property: property ?? this.property,
      visitor: visitor ?? this.visitor,
      dateRange: dateRange ?? this.dateRange,
      maxEntries: maxEntries ?? this.maxEntries,
    );
  }

  @override
  List<Object?> get props => [properties, visitors, property, visitor, dateRange, maxEntries];

  bool get isValid => property.isValid && visitor.isValid && dateRange.isValid && maxEntries.isValid;

  RegisterInvitationFormState validate() {
    return copyWith(
      property: property.validate(),
      visitor: visitor.validate(),
      dateRange: dateRange.validate(),
      maxEntries: maxEntries.validate(),
    );
  }
}
