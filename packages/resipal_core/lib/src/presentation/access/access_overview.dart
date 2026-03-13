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
    final colorScheme = Theme.of(context).colorScheme;

    // Lógica de métricas rápidas
    final activeInvitations = invitations.where((i) => i.isActive).length;
    final totalVisitors = visitors.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Tarjetas de Métricas Rápidas (Impacto Visual)
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Invitaciones Activas',
                  value: activeInvitations.toString(),
                  icon: Icons.qr_code_scanner_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: 'Total Visitantes',
                  value: totalVisitors.toString(),
                  icon: Icons.people_alt_outlined,
                ),
              ),
            ],
          ),



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

          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Registrar invitación',
                  onPressed: () {
                    // Go.to(const RegisterVisitorPage());
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

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

          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Registrar visitante',
                  onPressed: () {
                    // Go.to(const RegisterVisitorPage());
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 96),
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
