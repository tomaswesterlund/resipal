import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/enums/invitation_status.dart';
import 'package:ui/lib.dart';

class InvitationListView extends StatefulWidget {
  final List<InvitationEntity> invitations;

  const InvitationListView(this.invitations, {super.key});

  @override
  State<InvitationListView> createState() => _InvitationListViewState();
}

class _InvitationListViewState extends State<InvitationListView> {
  late FilterSelectorItem<InvitationStatus?> _selectedFilter;
  late List<FilterSelectorItem<InvitationStatus?>> _filterOptions;

  @override
  void initState() {
    super.initState();
    _filterOptions = [
      const FilterSelectorItem(label: 'Todas', value: null),
      const FilterSelectorItem(label: 'Activas', value: InvitationStatus.active),
      const FilterSelectorItem(label: 'Próximas', value: InvitationStatus.upcoming),
      const FilterSelectorItem(label: 'Expiradas', value: InvitationStatus.expired),
    ];
    _selectedFilter = _filterOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    // 1. Lógica de Filtrado usando el nuevo enum
    final filtered = _selectedFilter.value == null
        ? List<InvitationEntity>.from(widget.invitations)
        : widget.invitations.where((i) => i.status == _selectedFilter.value).toList();

    // 2. Ordenamiento: Por fecha de creación (Nuevas primero)
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    if (widget.invitations.isEmpty) return const _EmptyInvitations();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FilterSelector<InvitationStatus?>(
              options: _filterOptions,
              selectedValue: _selectedFilter,
              onSelected: (newItem) => setState(() => _selectedFilter = newItem),
            ),
            const SizedBox(height: 16.0),
            if (filtered.isEmpty)
              _buildEmptyFilterState(context)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (context, index) => InvitationTile(invitation: filtered[index]),
              ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFilterState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Icon(Icons.qr_code_scanner_rounded, color: Colors.grey.withOpacity(0.5), size: 48),
          const SizedBox(height: 12),
          BodyText.medium('No hay invitaciones que coincidan'),
        ],
      ),
    );
  }
}

class _EmptyInvitations extends StatelessWidget {
  const _EmptyInvitations();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.vignette_outlined, size: 64, color: colorScheme.primary.withOpacity(0.5)),
            const SizedBox(height: 24),
            HeaderText.four('Sin invitaciones'),
            const SizedBox(height: 12),
            BodyText.medium(
              'Las invitaciones QR generadas por los residentes aparecerán aquí.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
