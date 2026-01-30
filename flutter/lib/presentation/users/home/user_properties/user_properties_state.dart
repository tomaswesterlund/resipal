import 'package:equatable/equatable.dart';
import 'package:resipal/domain/entities/property_entity.dart';

class UserPropertiesState extends Equatable {
  final bool isFetching;
  final List<PropertyEntity> properties;
  final String? errorMessage;
  final Object? exception;

  bool get isError => errorMessage != null || exception != null;

  const UserPropertiesState({this.isFetching = true, this.properties = const [], this.errorMessage, this.exception});

  UserPropertiesState copyWith({bool? isFetching, List<PropertyEntity>? properties, String? errorMessage, Exception? exception}) {
    return UserPropertiesState(
      isFetching: isFetching ?? this.isFetching,
      properties: properties ?? this.properties,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [isFetching, properties, errorMessage, exception];
}
