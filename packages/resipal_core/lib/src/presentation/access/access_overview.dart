import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class AccessOverview extends StatelessWidget {
  final List<InvitationEntity> invitations;
  final List<VisitorEntity> visitors;

  const AccessOverview({required this.invitations, required this.visitors, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header de Control de Acceso Premium
          AccessHeader(invitations: invitations, visitors: visitors),

          const SizedBox(height: 32),

          // 3. Sección de Invitaciones Recientes
          Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeaderText(text: 'INVITACIONES RECIENTES'),
                TextButton(
                  onPressed: () => Go.to(InvitationsPage(invitations: invitations)),
                  child: BodyText.small('Ver todas', fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          if (invitations.isEmpty)
            const _MiniEmptyState(message: 'No hay invitaciones registradas')
          else
            ...invitations.take(3).map((inv) => InvitationTile(invitation: inv)),

          const SizedBox(height: 16),
          SecondaryButton(
            label: 'Registrar invitación',
            onPressed: () {
              // Go.to(const RegisterInvitationPage());
            },
          ),

          const SizedBox(height: 32),

          // 4. Sección de Últimos Visitantes
          Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeaderText(text: 'ÚLTIMOS VISITANTES'),
                TextButton(
                  onPressed: () => Go.to(VisitorsPage(visitors: visitors)),
                  child: BodyText.small('Ver todos', fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          if (visitors.isEmpty)
            const _MiniEmptyState(message: 'No hay registros de visitantes')
          else
            ...visitors.take(3).map((vis) => VisitorTile(visitor: vis)),

          const SizedBox(height: 16),
          SecondaryButton(
            label: 'Registrar visitante',
            onPressed: () {
              // Go.to(const RegisterVisitorPage());
            },
          ),

          const SizedBox(height: 96),
        ],
      ),
    );
  }
}

/// Header estilizado para métricas de Acceso
class AccessHeader extends StatelessWidget {
  final List<InvitationEntity> invitations;
  final List<VisitorEntity> visitors;

  const AccessHeader({required this.invitations, required this.visitors, super.key});

  @override
  Widget build(BuildContext context) {
    final activeInvitations = invitations.where((i) => i.isActive).length;
    final totalVisitors = visitors.length;

    return GradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Sección Superior
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_outlined, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              HeaderText.three('Control de Acceso', color: Colors.white),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          // Métrica Principal: Visitantes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Column(
                  children: [
                    OverlineText('INVITACIONES ACTIVAS', color: Colors.white.withOpacity(0.8)),
                    const SizedBox(height: 4),
                    Text(
                      activeInvitations.toString(),
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    OverlineText('VISITANTES REGISTRADOS', color: Colors.white.withOpacity(0.8)),
                    const SizedBox(height: 4),
                    Text(
                      totalVisitors.toString(),
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniEmptyState extends StatelessWidget {
  final String message;
  const _MiniEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: BodyText.small(message, color: Colors.grey),
      ),
    );
  }
}
