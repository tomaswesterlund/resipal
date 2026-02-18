import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/presentation/shared/floating_nav_bar.dart';
import 'package:resipal_user/presentation/home/user_access/user_access_view.dart';
import 'package:resipal_user/presentation/home/user_home/user_home_view.dart';
import 'package:resipal_user/presentation/home/user_payments/user_payments_view.dart';
import 'package:resipal_user/presentation/home/user_profile_view.dart';

class UserHomePage extends StatefulWidget {
  final UserEntity user;
  const UserHomePage({required this.user, super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          UserHomeView(userId: widget.user.id),
          UserPaymentsView(userId: widget.user.id),
          UserAccessView(userId: widget.user.id),
          UserProfileView(user: widget.user),
        ],
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _currentPageIndex,
        onChanged: (index) {
          setState(() => _currentPageIndex = index);
        },
        items: [
          FloatingNavBarItem(
            icon: Icons.home_outlined,
            label: 'Inicío',
            showDanger: widget.user.registry.hasDebt,
          ),
          FloatingNavBarItem(
            icon: Icons.attach_money,
            label: 'Pagos',
            badgeCount: widget.user.ledger.pendingPayments.length,
          ),
          FloatingNavBarItem(
            icon: Icons.door_front_door_outlined,
            label: 'Accesos',
            badgeCount: widget.user.activeInvitations.length,
          ),
          FloatingNavBarItem(icon: Icons.person_outline, label: 'Perfil'),
        ],
      ),
    );
  }
}
