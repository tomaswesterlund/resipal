// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/users/home/user_access_view.dart';
import 'package:resipal/presentation/users/home/home_view.dart';
import 'package:resipal/presentation/users/home/profile_view.dart';
import 'package:resipal/presentation/users/home/user_movements_view.dart';

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
      const HomeView(),
      UserMovementsView(user: widget.user),
      const UserAccessView(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Saldo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.door_front_door_outlined),
            label: 'Accesos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
