// import 'package:flutter/material.dart';
// import 'package:resipal/domain/entities/user_entity.dart';
// import 'package:resipal/presentation/users/home/user_access_view.dart';
// import 'package:resipal/presentation/users/home/user_home_view.dart';
// import 'package:resipal/presentation/users/home/user_profile_view.dart';
// import 'package:resipal/presentation/users/home/user_payments_view.dart';
// import 'package:resipal/presentation/users/home/user_properties_page.dart';

// class UserHomePage extends StatefulWidget {
//   final UserEntity user;
//   const UserHomePage({required this.user, super.key});

//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   int _currentPageIndex = 0;
//   late final List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       UserHomeView(user: widget.user),
//       UserPaymentsView(widget.user.payments),
//       UserAccessView(user: widget.user),
//       UserProfileView(user: widget.user),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentPageIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentPageIndex,
//         onTap: (index) {
//           setState(() {
//             _currentPageIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Inicio',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Pagos'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.door_front_door_outlined),
//             label: 'Accesos',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline_outlined),
//             label: 'Perfil',
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/users/home/user_access/user_access_view.dart';
import 'package:resipal/presentation/users/home/user_home_view.dart';
import 'package:resipal/presentation/users/home/user_profile_view.dart';
import 'package:resipal/presentation/users/home/user_payments_view.dart';

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
      UserPaymentsView(widget.user.payments),
      UserAccessView(user: widget.user),
      UserProfileView(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Allows the body to extend behind the floating navigation bar
      extendBody: true, 
      body: _pages[_currentPageIndex],
      bottomNavigationBar: _buildFloatingNavBar(),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(0, Icons.home_outlined, 'Home'),
          _navItem(1, Icons.credit_card_outlined, 'Mis Pagos'),
          _navItem(2, Icons.door_front_door_outlined, 'Accesos'),
          _navItem(3, Icons.person_outline, 'Perfil'),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final bool isActive = _currentPageIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentPageIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // Active state uses the secondary (Teal) color from AppColors
              color: isActive ? AppColors.secondary : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.hintText,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? AppColors.secondary : AppColors.hintText,
            ),
          ),
        ],
      ),
    );
  }
}