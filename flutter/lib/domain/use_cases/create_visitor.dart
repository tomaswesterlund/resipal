import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';

class CreateVisitor {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  Future call(CreateVisitorCommand command) async {
    await _source.createVisitor(
      userId: command.userId,
      name: command.name,
      identificationPath: command.identificationPath,
    );
  }
}

class CreateVisitorCommand {
  final String userId;
  final String name;
  final String identificationPath;

  CreateVisitorCommand({required this.userId, required this.name, required this.identificationPath});
}
