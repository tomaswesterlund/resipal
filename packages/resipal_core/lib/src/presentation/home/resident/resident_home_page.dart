import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/home/resident/resident_home_overview.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class ResidentHomePage extends StatefulWidget {
  final MemberEntity member;
  const ResidentHomePage({required this.member, super.key});

  @override
  State<ResidentHomePage> createState() => _ResidentHomePageState();
}

class _ResidentHomePageState extends State<ResidentHomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Resipal - Residente'),
      extendBody: true,
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          ResidentHomeOverview(member: widget.member),
          PropertyListView(widget.member.propertyRegistry.properties),
          PaymentListView(widget.member.paymentLedger.payments),
          Text('ACESSOS!'),
        ],
      ),
      drawer: Drawer(
        backgroundColor: context.colors.scheme.surface,
        width: MediaQuery.of(context).size.width * 0.85,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            WkDrawerHeader(name: widget.member.user.name, email: widget.member.user.email),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeaderText(text: 'CONFIGURACIÓN'),
                    const SizedBox(height: 16),

                    // WkDrawerItem(
                    //   icon: Icons.location_city_rounded,
                    //   label: 'Comunidad',
                    //   onTap: () => Go.to(CommunityDetailsPage(community: widget.member.community)),
                    // ),

                    // WkDrawerItem(
                    //   icon: Icons.people,
                    //   label: 'Miembros',
                    //   onTap: () => Go.to(MemberListPage(directory: community.memberDirectory)),
                    // ),
                    // WkDrawerItem(
                    //   icon: Icons.house,
                    //   label: 'Propiedades',
                    //   onTap: () => Go.to(PropertiesPage(community.propertyRegistry.properties)),
                    // ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Divider(thickness: 1)),
                    const SectionHeaderText(text: 'SISTEMA'),
                    const SizedBox(height: 16),
                    WkDrawerItem(
                      icon: Icons.settings,
                      label: 'Configuración',
                      onTap: () => Go.to(const SettingsPage()),
                    ),
                    // WkDrawerItem(
                    //   icon: Icons.logout_rounded,
                    //   label: 'Cerrar Sesión',
                    //   color: context.colors.scheme.error,
                    //   onTap: () => context.read<HomePageCubit>().signout(),
                    // ),
                    const SizedBox(height: 12.0),
                    Center(
                      child: Text(
                        'Resipal Admin v1.0.4',
                        style: context.textStyles.labelSmall.copyWith(color: context.colors.scheme.outline),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
