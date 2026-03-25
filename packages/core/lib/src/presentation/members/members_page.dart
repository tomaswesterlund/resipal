import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:core/src/presentation/members/member_list_view.dart';
import 'package:ui/lib.dart';

class MembersPage extends StatelessWidget {
  final MemberDirectoryEntity directory;
  const MembersPage({required this.directory, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Miembros'),
      body: MemberListView(directory.members),
    );
  }
}
