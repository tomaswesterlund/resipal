import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/properties/property_list_view.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

enum ResidentPage { home, properties, payments, access }

class ResidentHomePage extends StatefulWidget {
  final CommunityEntity community;
  final ResidentMemberEntity resident;
  const ResidentHomePage({required this.community, required this.resident, super.key});

  @override
  State<ResidentHomePage> createState() => _ResidentHomePageState();
}

class _ResidentHomePageState extends State<ResidentHomePage> {
  int _currentPageIndex = ResidentPage.home.index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => ResidentHomePageCubit()..initialize(widget.community, widget.resident),
      child: BlocBuilder<ResidentHomePageCubit, ResidentHomePageState>(
        builder: (context, state) {
          // Extraemos el member actualizado del estado, o usamos el inicial de las props
          final community = (state is ResidentLoadedState) ? state.community : widget.community;
          final resident = (state is ResidentLoadedState) ? state.resident : widget.resident;

          return Scaffold(
            appBar: MyAppBar(title: _getAppBarTitle(), actions: _getAppBarActions(context)),
            extendBody: true,
            backgroundColor: colorScheme.background,
            body: IndexedStack(
              index: _currentPageIndex,
              children: [
                ResidentHomeOverview(resident: resident),
                PropertyListView(resident.propertyRegistry.properties),
                PaymentListView(resident.paymentLedger.payments),
                AccessOverview(invitations: resident.invitations, visitors: resident.visitors),
              ],
            ),
            drawer: Drawer(
              backgroundColor: colorScheme.surface,
              width: MediaQuery.of(context).size.width * 0.85,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  WkDrawerHeader(name: resident.user.name, email: resident.user.email),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeaderText(text: 'OPCIONES'),
                          const SizedBox(height: 16),
                          WkDrawerItem(
                            icon: Icons.location_city_rounded,
                            label: 'Mi Comunidad',
                            onTap: () => Go.to(CommunityDetailsPage(community: community)),
                          ),
                          WkDrawerItem(icon: Icons.person, label: 'Mi Perfil', onTap: () => {}),

                          SizedBox(height: 12),
                          Divider(thickness: 1),
                          SizedBox(height: 24),

                          WkDrawerItem(
                            icon: Icons.logout_rounded,
                            label: 'Cerrar Sesión',
                            color: colorScheme.error,
                            onTap: () => context.read<ResidentHomePageCubit>().signout(),
                          ),
                          const SizedBox(height: 24.0),
                          Center(
                            child: Text(
                              'Resipal Residente v1.0.4',
                              style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
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
              onChanged: (index) => setState(() => _currentPageIndex = index),
              items: [
                FloatingNavBarItem(icon: Icons.dashboard_outlined, label: 'Inicio'),
                FloatingNavBarItem(
                  icon: Icons.house_outlined,
                  label: 'Propiedades',
                  showDanger: resident.propertyRegistry.hasOverdueFees,
                  warningBadgeCount: resident.propertyRegistry.withDueFees.length,
                ),
                FloatingNavBarItem(
                  icon: Icons.attach_money,
                  label: 'Pagos',
                  warningBadgeCount: resident.paymentLedger.pendingPayments.length,
                ),
                FloatingNavBarItem(icon: Icons.door_front_door_outlined, label: 'Accesos'),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getAppBarTitle() {
    const titles = ['Resipal - Residente', 'Mis Propiedades', 'Mis Pagos', 'Accesos'];
    return titles[_currentPageIndex];
  }

  List<Widget> _getAppBarActions(BuildContext context) {
    switch (_currentPageIndex) {
      case 0:
        return [IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {})];
      case 2: // Pestaña de Pagos
        return [IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(const RegisterPaymentPage()))];
      default:
        return [];
    }
  }
}
