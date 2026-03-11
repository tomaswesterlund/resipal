import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart' hide HomeOverview;
import 'package:resipal_resident/presentation/home/home_overview.dart';
import 'package:wester_kit/lib.dart';

class HomePage extends StatefulWidget {
  final MemberEntity member;
  const HomePage({required this.member, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          HomeOverview(member: widget.member),
          PropertyListView(widget.member.propertyRegistry.properties),
          PaymentListView(widget.member.paymentLedger.payments),
          Text('ACESSOS!'),
        ],
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _currentPageIndex,
        onChanged: (index) {
          setState(() => _currentPageIndex = index);
        },
        items: [
          FloatingNavBarItem(icon: Icons.dashboard_outlined, label: 'Inicio'),
          FloatingNavBarItem(
            icon: Icons.house_outlined,
            label: 'Propiedades',
            badgeCount: -1, //widget.member.activeInvitations.length,
          ),
          FloatingNavBarItem(
            icon: Icons.attach_money,
            label: 'Pagos',
            badgeCount: widget.member.paymentLedger.pendingPayments.length,
          ),

          FloatingNavBarItem(
            icon: Icons.door_front_door_outlined,
            label: 'Accesos',
            badgeCount: -1, //widget.member.activeInvitations.length,
          ),
        ],
      ),
    );
  }
}
