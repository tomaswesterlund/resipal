import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/entities/visitor_entity.dart';

class CreateInvitationFormState {
  final List<PropertyEntity> properties;
  final List<VisitorEntity> visitors;

  final PropertyEntity? property;
  final VisitorEntity? visitor;
  final DateTimeRange? dateRange;

  bool get canSubmit {
    if (property == null) return false;
    if (visitor == null) return false;
    if (dateRange == null) return false;

    return true;
  }

  CreateInvitationFormState({
    required this.properties,
    required this.visitors,
    this.property,
    this.visitor,
    this.dateRange,
  });

  CreateInvitationFormState copyWith({PropertyEntity? property, VisitorEntity? visitor, DateTimeRange? dateRange}) {
    return CreateInvitationFormState(
      properties: properties,
      visitors: visitors,
      property: property ?? this.property,
      visitor: visitor ?? this.visitor,
      dateRange: dateRange ?? this.dateRange,
    );
  }
}
