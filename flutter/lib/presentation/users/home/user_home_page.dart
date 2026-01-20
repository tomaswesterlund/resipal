import 'package:flutter/material.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/presentation/users/home/access_view.dart';
import 'package:resipal/presentation/users/home/home_view.dart';
import 'package:resipal/presentation/users/home/user_movements/user_movements_view.dart';
import 'package:resipal/presentation/users/home/profile_view.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    HomeView(),
    UserMovementsView(),
    AccessView(),
    ProfileView(),
  ];

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
            icon: Icon(Icons.credit_card),
            label: 'Mis pagos',
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
