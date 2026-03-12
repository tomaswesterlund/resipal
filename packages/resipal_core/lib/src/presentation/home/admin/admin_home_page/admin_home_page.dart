import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/src/presentation/home/admin/admin_home_overview/admin_home_overview.dart';
import 'package:resipal_core/src/presentation/home/admin/admin_home_page/admin_home_page_cubit.dart';
import 'package:resipal_core/src/presentation/home/admin/admin_home_page/admin_home_page_state.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

enum HomePage { home, properties, payments, applications, members }

class AdminHomePage extends StatefulWidget {
  final CommunityEntity community;
  final UserEntity user;

  const AdminHomePage({required this.community, required this.user, super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentPageIndex = HomePage.home.index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => AdminHomePageCubit()..initialize(widget.community, widget.user),
      child: BlocBuilder<AdminHomePageCubit, AdminHomePageState>(
        builder: (context, state) {
          final community = (state is AdminLoadedState) ? state.community : widget.community;
          final user = (state is AdminLoadedState) ? state.user : widget.user;

          return Scaffold(
            appBar: MyAppBar(title: _getAppBarTitle(), actions: _getAppBarActions()),
            extendBody: true,
            backgroundColor: colorScheme.background,
            body: IndexedStack(
              index: _currentPageIndex,
              children: [
                AdminHomeOverview(
                  community: community,
                  user: user,
                  onPendingApplicationsPressed: () =>
                      setState(() => _currentPageIndex = HomePage.applications.index),
                  onPendingPaymentsPressed: () => setState(() => _currentPageIndex = HomePage.payments.index),
                ),
                PropertyListView(community.propertyRegistry.properties),
                PaymentListView(community.paymentLedger.payments),
                ApplicationListView(community.applications),
                MemberListView(community.memberDirectory.members),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 0.0, left: 0.0, right: 0.0),
              child: FloatingNavBar(
                currentIndex: _currentPageIndex,
                onChanged: (index) => setState(() => _currentPageIndex = index),
                items: [
                  FloatingNavBarItem(icon: Icons.dashboard_outlined, label: 'Inicio'),
                  FloatingNavBarItem(
                    icon: Icons.home_work_outlined,
                    label: 'Propiedades',
                    showDanger: community.propertyRegistry.hasOverdueFees,
                    warningBadgeCount: community.propertyRegistry.withPendingFees.length,
                  ),
                  FloatingNavBarItem(
                    icon: Icons.attach_money,
                    label: 'Pagos',
                    warningBadgeCount: community.paymentLedger.pendingPayments.length,
                  ),
                  FloatingNavBarItem(
                    icon: Icons.document_scanner,
                    label: 'Solicitudes',
                    warningBadgeCount: community.applications.length,
                  ),
                  FloatingNavBarItem(icon: Icons.groups_outlined, label: 'Miembros'),
                ],
              ),
            ),
            drawer:Drawer (
              backgroundColor: colorScheme.background,
              width: MediaQuery.of(context).size.width * 0.85,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  WkDrawerHeader(name: community.name, email: user.email),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeaderText(text: 'CONFIGURACIÓN'),
                          const SizedBox(height: 16),
                          WkDrawerItem(
                            icon: Icons.location_city_rounded,
                            label: 'Comunidad',
                            onTap: () => Go.to(CommunityDetailsPage(community: community)),
                          ),
                          WkDrawerItem(
                            icon: Icons.description,
                            label: 'Contratos',
                            onTap: () => Go.to(ContractsPage(community.contracts)),
                          ),
                          WkDrawerItem(
                            icon: Icons.people,
                            label: 'Miembros',
                            onTap: () => Go.to(MemberListPage(directory: community.memberDirectory)),
                          ),
                          WkDrawerItem(
                            icon: Icons.house,
                            label: 'Propiedades',
                            onTap: () => Go.to(PropertiesPage(community.propertyRegistry.properties)),
                          ),
                          WkDrawerItem(
                            icon: Icons.bar_chart_outlined,
                            label: 'Reportes',
                            onTap: () => Go.to(const ReportsPage()),
                          ),
                          WkDrawerItem(
                            icon: Icons.manage_accounts,
                            label: 'Roles',
                            onTap: () => Go.to(const RolesPage()),
                          ),
                          WkDrawerItem(
                            icon: Icons.document_scanner,
                            label: 'Solicitudes',
                            onTap: () => Go.to(ApplicationListPage(applications: community.applications)),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Divider(thickness: 1)),
                          const SectionHeaderText(text: 'SISTEMA'),
                          const SizedBox(height: 16),
                          WkDrawerItem(
                            icon: Icons.settings,
                            label: 'Configuración',
                            onTap: () => Go.to(const SettingsPage()),
                          ),
                          WkDrawerItem(
                            icon: Icons.logout_rounded,
                            label: 'Cerrar Sesión',
                            color: colorScheme.error,
                            onTap: () => context.read<AdminHomePageCubit>().signout(),
                          ),
                          const SizedBox(height: 12.0),
                          Center(
                            child: Text(
                              'Resipal Admin v1.0.4',
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
          );
        },
      ),
    );
  }

  String _getAppBarTitle() {
    const titles = ['Resipal - Administrator', 'Propiedades', 'Pagos', 'Solicitudes', 'Miembros'];
    return titles[_currentPageIndex];
  }

  List<Widget> _getAppBarActions() {
    switch (_currentPageIndex) {
      case 0:
        return [IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {})];
      case 1:
        return [IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterPropertyPage()))];
      case 2:
        return [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => InfoPopup.show(
              context,
              title: 'Información de Pagos',
              message:
                  'Los pagos que se encuentran en revisión tienen que ser aprobados por un administrador. El saldo total del miembro no se verá afectado hasta que un administrador verifique el comprobante y apruebe el pago.',
              icon: Icons.info_outline,
              iconColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterPaymentPage())),
        ];
      case 3:
        return [
          // IconButton(icon: const Icon(Icons.help), onPressed: () {}),
          // IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterApplicationPage())),
        ];

      case 4:
        return [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => InfoPopup.show(
              context,
              title: 'Información de Miembros',
              message:
                  'Para registrar a un miembro, primero debes crear una nueva solicitud. El futuro miembro recibirá una invitación y, al aceptarla, se unirá automáticamente a la comunidad.',
              icon: Icons.info_outline,
            ),
          ),
        ];
      default:
        return [];
    }
  }
}
