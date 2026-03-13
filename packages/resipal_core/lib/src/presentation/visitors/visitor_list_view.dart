import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/visitors/visitor_tile.dart';
import 'package:wester_kit/lib.dart';

class VisitorListView extends StatefulWidget {
  final List<VisitorEntity> visitors;

  const VisitorListView(this.visitors, {super.key});

  @override
  State<VisitorListView> createState() => _VisitorListViewState();
}

class _VisitorListViewState extends State<VisitorListView> {
  late FilterSelectorItem<bool?> _selectedFilter;
  late List<FilterSelectorItem<bool?>> _filterOptions;

  @override
  void initState() {
    super.initState();
    _filterOptions = [
      const FilterSelectorItem(label: 'Todos', value: null),
      const FilterSelectorItem(label: 'Registrados hoy', value: true),
    ];
    _selectedFilter = _filterOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Filter Logic: Filtrar por fecha si el valor es true
    final filteredVisitors = _selectedFilter.value == null
        ? widget.visitors
        : widget.visitors.where((v) {
            final now = DateTime.now();
            return v.createdAt.year == now.year && v.createdAt.month == now.month && v.createdAt.day == now.day;
          }).toList();

    // 2. Sort by Date (Más recientes primero)
    filteredVisitors.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    if (widget.visitors.isEmpty) return const _Empty();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FilterSelector<bool?>(
              options: _filterOptions,
              selectedValue: _selectedFilter,
              onSelected: (newItem) {
                setState(() {
                  _selectedFilter = newItem;
                });
              },
            ),

            const SizedBox(height: 16.0),

            if (filteredVisitors.isEmpty)
              _buildEmptyFilterState(context)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredVisitors.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final visitor = filteredVisitors[index];
                  return VisitorTile(visitor: visitor);
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
          Icon(Icons.person_search_outlined, color: colorScheme.primary.withOpacity(0.5), size: 48),
          const SizedBox(height: 12),
          Text(
            _selectedFilter.value == true
                ? 'No hay visitantes registrados el día de hoy.'
                : 'No se encontraron visitantes.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.inverseSurface, fontWeight: FontWeight.w500),
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
            HeaderText.four('Sin visitantes', textAlign: TextAlign.center, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Aún no se han registrado visitantes.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.inverseSurface),
            ),
            const SizedBox(height: 32),
            // Botón de acción para registrar visita rápida si fuera necesario
            PrimaryButton(label: 'Registrar visitante', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
