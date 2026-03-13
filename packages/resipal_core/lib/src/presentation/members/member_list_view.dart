import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class MemberListView extends StatefulWidget {
  final List<MemberEntity> members;

  const MemberListView(this.members, {super.key});

  @override
  State<MemberListView> createState() => _MemberListViewState();
}

class _MemberListViewState extends State<MemberListView> {
  late FilterSelectorItem<String?> _selectedFilter;
  late List<FilterSelectorItem<String?>> _filterOptions;

  @override
  void initState() {
    super.initState();
    _filterOptions = [
      const FilterSelectorItem(label: 'Todos', value: null),
      const FilterSelectorItem(label: 'Admin', value: 'admin'),
      const FilterSelectorItem(label: 'Residente', value: 'resident'),
      const FilterSelectorItem(label: 'Seguridad', value: 'security'),
    ];
    _selectedFilter = _filterOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Lógica de Filtrado
    final filteredMembers = widget.members.where((member) {
      if (_selectedFilter.value == null) return true;
      if (_selectedFilter.value == 'admin') return member.isAdmin;
      if (_selectedFilter.value == 'resident') return member.isResident;
      if (_selectedFilter.value == 'security') return member.isSecurity;
      return true;
    }).toList();

    // 2. Ordenar por nombre
    filteredMembers.sort((a, b) => a.name.compareTo(b.name));

    if (widget.members.isEmpty) return const _Empty();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Selector de Filtros
            FilterSelector<String?>(
              options: _filterOptions,
              selectedValue: _selectedFilter,
              onSelected: (newItem) {
                setState(() {
                  _selectedFilter = newItem;
                });
              },
            ),

            const SizedBox(height: 16.0),

            if (filteredMembers.isEmpty)
              _buildEmptyFilterState(context)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredMembers.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final member = filteredMembers[index];
                  return MemberTile(member: member);
                },
              ),

            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFilterState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Icon(
            Icons.group_off_outlined,
            color: colorScheme.primary.withOpacity(0.5),
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'No hay ${_selectedFilter.label.toLowerCase()}s en esta comunidad.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.inverseSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.people_outline, size: 64, color: colorScheme.primary),
            ),
            const SizedBox(height: 32),
            HeaderText.four('Sin miembros', textAlign: TextAlign.center, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'No hay miembros registrados en esta comunidad todavía.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}