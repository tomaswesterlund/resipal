import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';

enum HomePage { home, properties, payments, applications, members }

class AdminHomePage extends StatefulWidget {
  final AdminMemberEntity admin;
  final CommunityEntity community;

  const AdminHomePage({required this.admin, required this.community, super.key});

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
      create: (context) => AdminHomeCubit()..initialize(widget.admin, widget.community),
      child: BlocBuilder<AdminHomeCubit, AdminHomeState>(
        builder: (context, state) {
          final admin = (state is AdminLoadedState) ? state.admin : widget.admin;
          final community = (state is AdminLoadedState) ? state.community : widget.community;

          return Scaffold(
            appBar: MyAppBar(
              title: _getAppBarTitle(),
              actions: [
                if (_currentPageIndex == HomePage.home.index)
                  IconButton(
                    icon: Badge(
                      // We only show the badge if there are unread notifications
                      isLabelVisible: admin.unreadNotifications.length > 0,
                      label: Text(admin.unreadNotifications.length.toString()),
                      child: const Icon(Icons.notifications_none),
                    ),
                    onPressed: () => Go.to(NotificationsPage(admin.notifications)),
                  ),
                if (_currentPageIndex == HomePage.properties.index)
                  IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterPropertyPage())),
                if (_currentPageIndex == HomePage.payments.index) ...[
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => InfoPopup.show(
                      context,
                      title: 'Información de Pagos',
                      message:
                          'Los pagos que se encuentran en revisión tienen que ser aprobados por un administrador. El saldo total del miembro no se verá afectado hasta que un administrador verifique el comprobante y apruebe el pago.',
                      icon: Icons.info_outline,
                      iconColor: colorScheme.primary,
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterPaymentPage())),
                ],
                if (_currentPageIndex == HomePage.applications.index)
                  IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterApplicationPage())),
                if (_currentPageIndex == HomePage.members.index)
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
              ],
            ),
            extendBody: true,
            backgroundColor: colorScheme.background,
            body: IndexedStack(
              index: _currentPageIndex,
              children: [
                AdminHomeOverview(
                  admin: admin,
                  community: community,
                  onPendingApplicationsPressed: () => setState(() => _currentPageIndex = HomePage.applications.index),
                  onPendingPaymentsPressed: () => setState(() => _currentPageIndex = HomePage.payments.index),
                ),
                PropertiesView(
                  registry: community.registry,
                  showNoActiveContractInformation: community.contracts.length == 0,
                  showRegisterProperty: true,
                ),

                PaymentListView(community.ledger.payments),
                ApplicationListView(community.applications),
                MemberListView(community.directory.members),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, left: 0.0, right: 0.0),
              child: FloatingNavBar(
                currentIndex: _currentPageIndex,
                onChanged: (index) => setState(() => _currentPageIndex = index),
                items: [
                  FloatingNavBarItem(icon: Icons.dashboard_outlined, label: 'Inicio'),
                  FloatingNavBarItem(
                    icon: Icons.home_work_outlined,
                    label: 'Propiedades',
                    showDanger: community.registry.hasOverdueFees,
                    warningBadgeCount: community.registry.withDueFees.length,
                  ),
                  FloatingNavBarItem(
                    icon: Icons.attach_money,
                    label: 'Pagos',
                    warningBadgeCount: community.ledger.pendingPayments.length,
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
            drawer: Drawer(
              backgroundColor: colorScheme.background,
              width: MediaQuery.of(context).size.width * 0.85,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  WkDrawerHeader(name: community.name, email: admin.user.email),
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
                            onTap: () => Go.to(MembersPage(directory: community.directory)),
                          ),
                          WkDrawerItem(
                            icon: Icons.home_work,
                            label: 'Propiedades',
                            onTap: () => Go.to(PropertiesPage(community.registry)),
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
                          WkDrawerItem(icon: Icons.help, label: 'Ayuda', onTap: () => Go.to(HelpPage())),
                          WkDrawerItem(
                            icon: Icons.settings,
                            label: 'Configuración',
                            onTap: () => Go.to(const SettingsPage()),
                          ),

                          WkDrawerItem(
                            icon: Icons.logout_rounded,
                            label: 'Cerrar Sesión',
                            color: colorScheme.error,
                            onTap: () => context.read<AdminHomeCubit>().signout(),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Divider(thickness: 1)),

                          if (kDebugMode) ...[
                            const SectionHeaderText(text: 'Debug'),
                            const SizedBox(height: 16),
                            WkDrawerItem(
                              icon: Icons.message,
                              label: 'WhatsApp',
                              onTap: () => Go.to(const SendWhatsappMessagePage()),
                            ),
                          ],
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
}
