import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';
import 'package:resipal/domain/refs/visitor_ref.dart';
import 'package:resipal/domain/repositories/user_repository.dart';

class VisitorRepository {
  final VisitorDataSource _visitorDataSource = GetIt.I<VisitorDataSource>();

  Future<List<VisitorEntity>> getVisitorsByUserId(String userId) async {
    final UserRepository userRepository = GetIt.I<UserRepository>();
    
    final models = await _visitorDataSource.getVisitorsByUserId(userId);
    final futures = models.map((m) async => VisitorEntity(id: m.id, user: await userRepository.getUserRefById(m.userId), createdAt: m.createdAt, name: m.name));
    final entities = await Future.wait(futures);
    return entities;
  }

  Future<VisitorRef> getVisitoryRefById(String id) async {
    final model = await _visitorDataSource.getVisitorById(id);
    final ref = VisitorRef(id: model.id, name: model.name);
    return ref;
  }
}