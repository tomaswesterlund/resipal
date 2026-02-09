import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/visitor_model.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';
import 'package:resipal/domain/refs/visitor_ref.dart';

class VisitorRepository {
  final VisitorDataSource _visitorDataSource = GetIt.I<VisitorDataSource>();

  final Map<String, VisitorEntity> _cache = {};

  Stream<List<VisitorEntity>> watchVisitorsByUserId(String userId) {
    return _visitorDataSource.watchVisitorsByUserId(userId).asyncMap((models) async {
      final entities = await _processAndCache(models);
      return entities;
    });
  }

  List<VisitorEntity> getVisitorsByUserId(String userId) => _cache.values.where((v) => v.userId == userId).toList();

  Future<VisitorRef> getVisitoryRefById(String id) async {
    final model = await _visitorDataSource.getVisitorById(id);
    final ref = VisitorRef(id: model.id, name: model.name);
    return ref;
  }

  Future createVisitor({required String userId, required String name, required String identificationPath}) =>
      _visitorDataSource.createVisitor(userId: userId, name: name, identificationPath: identificationPath);

  VisitorEntity _toEntity(VisitorModel model) {
    return VisitorEntity(
      id: model.id,
      userId: model.userId,
      createdAt: model.createdAt,
      name: model.name,
      identificationPath: model.identificationPath,
    );
  }

  Future<List<VisitorEntity>> _processAndCache(List<VisitorModel> models) async {
    final futures = models.map((model) async {
      if (_cache.containsKey(model.id)) {
        return _cache[model.id]!;
      }

      final entity = await _toEntity(model);
      _cache[model.id] = entity;
      return entity;
    }).toList();

    final list = Future.wait(futures);
    return list;
  }
}
