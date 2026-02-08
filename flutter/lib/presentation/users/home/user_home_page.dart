import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/floating_nav_bar.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/users/home/user_access/user_access_view.dart';
import 'package:resipal/presentation/users/home/user_home/user_home_view.dart';
import 'package:resipal/presentation/users/home/user_ledger/user_ledger_view.dart';
import 'package:resipal/presentation/users/home/user_profile_view.dart';

class UserHomePage extends StatefulWidget {
  final UserEntity user;
  const UserHomePage({required this.user, super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _currentPageIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      UserHomeView(user: widget.user),
      UserLedgerView(user: widget.user),
      UserAccessView(user: widget.user),
      UserProfileView(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentPageIndex],
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _currentPageIndex,
        onChanged: (index) {
          setState(() => _currentPageIndex = index);
        },
        items: [
          FloatingNavBarItem(icon: Icons.home_outlined, label: 'Home'),
          FloatingNavBarItem(icon: Icons.currency_exchange_outlined, label: 'Movimientos'),
          FloatingNavBarItem(icon: Icons.door_front_door_outlined, label: 'Accesos'),
          FloatingNavBarItem(icon: Icons.person_outline, label: 'Perfil'),
        ],
      ),
    );
  }
}
