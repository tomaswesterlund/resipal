import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';
import 'package:resipal_core/presentation/shared/floating_nav_bar.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: Text('ADMIN HOME PAGE'),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: 0,
        onChanged: (index) {},
        items: [
          FloatingNavBarItem(icon: Icons.house, label: 'Inicío'),
          FloatingNavBarItem(icon: Icons.house, label: 'Propiedades'),
          FloatingNavBarItem(icon: Icons.attach_money, label: 'Pagos', badgeCount: 2),
          FloatingNavBarItem(icon: Icons.abc, label: 'Usuarios'),
        ],
      ),
    );
  }
}
