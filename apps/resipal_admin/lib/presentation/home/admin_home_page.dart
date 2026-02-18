import 'package:flutter/material.dart';
import 'package:resipal_admin/presentation/home/admin_payments_view.dart';
import 'package:resipal_admin/presentation/home/admin_properties_view.dart';
import 'package:resipal_admin/presentation/home/admin_users_view.dart';
import 'package:resipal_core/domain/entities/community_entity.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';
import 'package:resipal_core/presentation/shared/floating_nav_bar.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';
import 'package:resipal_core/presentation/shared/texts/section_header_text.dart';

class AdminHomePage extends StatefulWidget {
  final CommunityEntity community;
  final UserEntity user;

  const AdminHomePage({required this.community, required this.user, super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Resipal - Administrator'),
      extendBody: true,
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          Text('Home'),
          AdminPropertiesView(widget.community.registry),
          AdminPaymensView(widget.community.ledger),
          AdminUserView(),
        ],
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _currentPageIndex,
        onChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          FloatingNavBarItem(icon: Icons.house, label: 'Inicío'),
          FloatingNavBarItem(icon: Icons.house, label: 'Propiedades'),
          FloatingNavBarItem(
            icon: Icons.attach_money,
            label: 'Pagos',
            warningBadgeCount: widget.community.ledger.pendingPayments.length,
          ),
          FloatingNavBarItem(icon: Icons.people, label: 'Usuarios'),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 24.0),
            child: Column(
              children: [
                SectionHeaderText(text: 'CONFIGURACIóN'),
                BodyText.medium('Communidad'),
                BodyText.medium('Contratos'),
                BodyText.medium('Propiedades'),
                BodyText.medium('Usuarios'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
