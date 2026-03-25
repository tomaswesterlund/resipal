import 'package:core/lib.dart';

class MemberDirectoryEntity {
  final List<MemberEntity> members;

  MemberDirectoryEntity(this.members);

  bool get isEmpty => members.isEmpty;
  int get count => members.length;

  List<MemberEntity> get admins => members.where((x) => x.isAdmin).toList();
  List<MemberEntity> get residents =>  members.where((x) => x.isResident).toList();
  List<MemberEntity> get securityStaff => members.where((x) => x.isSecurity).toList();
  
  
  List<MemberEntity> get pendingApplications =>  members;//users.where((m) => m.applicationStatus == ApplicationStatus.pendingReview).toList();


}
