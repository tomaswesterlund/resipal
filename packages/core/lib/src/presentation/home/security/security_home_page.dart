import 'package:core/lib.dart';
import 'package:flutter/material.dart';
import 'package:core/src/presentation/access/scan_invitation/scan_invitation_page.dart';
import 'package:core/src/presentation/qr/qr_scanner_view.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/lib.dart';
import 'package:short_navigation/short_navigation.dart';

class SecurityHomePage extends StatelessWidget {
  final MemberEntity member;
  const SecurityHomePage({required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const MyAppBar(title: 'Resipal Security', automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            HeaderText.four('Panel de Vigilancia'),
            const SizedBox(height: 4),
            BodyText.medium('Selecciona una acción rápida'),

            const SizedBox(height: 32),

            // --- ACCIÓN PRINCIPAL: SCAN QR ---
            // Un botón gigante y centralizado para la función más usada
            InkWell(
              onTap: () => Go.to(ScanInvitationPage()),
              borderRadius: BorderRadius.circular(32),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 48),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(color: colorScheme.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.qr_code_scanner_rounded, size: 80, color: Colors.white),
                    const SizedBox(height: 16),
                    Text(
                      'ESCANEAR PASE QR',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- ACCIONES SECUNDARIAS ---
            // Row(
            //   children: [
            //     // Registro de Paquetes
            //     Expanded(
            //       child: _SecurityActionCard(
            //         icon: Icons.inventory_2_outlined,
            //         label: 'Recibir Paquete',
            //         onTap: () => _handleRegisterPackage(context),
            //       ),
            //     ),
            //     // const SizedBox(width: 16),
            //     // // Registro Manual o similar
            //     // Expanded(
            //     //   child: _SecurityActionCard(
            //     //     icon: Icons.edit_note_rounded,
            //     //     label: 'Entrada Manual',
            //     //     onTap: () {},
            //     //   ),
            //     // ),
            //   ],
            // ),
            // const SizedBox(height: 16),

            // // --- ACCIÓN DE ALTA VISIBILIDAD: INCIDENTES ---
            // // Color 'error' (Rojo) para que destaque inmediatamente
            // DefaultCard(
            //   child: ListTile(
            //     onTap: () => _handleReportIncident(context),
            //     leading: Container(
            //       padding: const EdgeInsets.all(12),
            //       decoration: BoxDecoration(color: colorScheme.error.withOpacity(0.1), shape: BoxShape.circle),
            //       child: Icon(Icons.warning_amber_rounded, color: colorScheme.error),
            //     ),
            //     title: HeaderText.five('REPORTAR INCIDENTE', color: colorScheme.error),
            //     subtitle: const OverlineText('Urgencias o anomalías'),
            //     trailing: Icon(Icons.chevron_right_rounded, color: colorScheme.error),
            //   ),
            // ),

            // const SizedBox(height: 48),
            Spacer(),

            Center(
              child: Opacity(
                opacity: 0.5,
                child: Column(
                  children: [
                    const Icon(Icons.shield_outlined, size: 24),
                    const SizedBox(height: 8),
                    const OverlineText('SISTEMA DE SEGURIDAD ACTIVO'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: colorScheme.surface,
        width: MediaQuery.of(context).size.width * 0.85,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            WkDrawerHeader(name: member.user.name, email: member.user.email),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SectionHeaderText(text: 'OPCIONES'),
                    // const SizedBox(height: 16),
                    // WkDrawerItem(
                    //   icon: Icons.location_city_rounded,
                    //   label: 'Mi Comunidad',
                    //   onTap: () => Go.to(CommunityDetailsPage(community: community)),
                    // ),
                    // WkDrawerItem(icon: Icons.person, label: 'Mi Membresía', onTap: () => {}),
                    // WkDrawerItem(icon: Icons.help, label: 'Ayuda', onTap: () => Go.to(HelpPage())),

                    // SizedBox(height: 12),
                    // Divider(thickness: 1),
                    // SizedBox(height: 24),

                    WkDrawerItem(
                      icon: Icons.logout_rounded,
                      label: 'Cerrar Sesión',
                      color: colorScheme.error,
                      onTap: () => GetIt.I<AuthService>().signout(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegisterPackage(BuildContext context) {
    print("Abriendo registro de paquetería...");
  }

  void _handleReportIncident(BuildContext context) {
    print("Iniciando reporte de incidente...");
  }
}

/// Tarjeta personalizada para acciones de seguridad
class _SecurityActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SecurityActionCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultCard(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Icon(icon, size: 32, color: colorScheme.primary),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
