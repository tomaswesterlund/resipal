import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';

class RegisterInvitationFormState extends Equatable {
  final List<PropertyEntity> properties;
  final List<VisitorEntity> visitors;

  final PropertyEntity? property;
  final VisitorEntity? visitor;
  final DateTimeRange? dateRange;
  final int? maxEntries;

  const RegisterInvitationFormState({
    required this.properties,
    required this.visitors,
    this.property,
    this.visitor,
    this.dateRange,
    this.maxEntries,
  });

  bool get canSubmit => property != null && visitor != null && dateRange != null;

  RegisterInvitationFormState copyWith({
    List<PropertyEntity>? properties,
    List<VisitorEntity>? visitors,
    PropertyEntity? property,
    VisitorEntity? visitor,
    DateTimeRange? dateRange,
    int? maxEntries,
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
}
