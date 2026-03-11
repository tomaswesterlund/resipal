import 'package:resipal_core/lib.dart';

class MemberDirectoryEntity {
  final List<MemberEntity> members;

  MemberDirectoryEntity(this.members);

  bool get isEmpty => members.isEmpty;
  int get length => members.length;

  List<MemberEntity> get admins => members; //users.where((m) => m.isAdmin).toList();
  List<MemberEntity> get securityStaff => members; //users.where((m) => m.isSecurity).toList();
  List<MemberEntity> get residents =>  members;//users.where((m) => m.isResident).toList();
  
  List<MemberEntity> get pendingApplications =>  members;//users.where((m) => m.applicationStatus == ApplicationStatus.pendingReview).toList();


}
