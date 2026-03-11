import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class PropertyDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PropertyDetailsLoadingState extends PropertyDetailsState {}

class PropertyDetailsLoadedState extends PropertyDetailsState {
  final PropertyEntity property;

  PropertyDetailsLoadedState(this.property);

  @override
  List<Object?> get props => [property];
}

class PropertyDetailsErrorState extends PropertyDetailsState {}
