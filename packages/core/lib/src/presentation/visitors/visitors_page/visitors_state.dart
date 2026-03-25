import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

abstract class VisitorsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisitorsInitialState extends VisitorsState {}

class VisitorsLoadingState extends VisitorsState {}

class VisitorsLoadedState extends VisitorsState {
  final List<VisitorEntity> visitors;

  VisitorsLoadedState(this.visitors);

  @override
  List<Object?> get props => [visitors];
}

class VisitorsErrorState extends VisitorsState {}
