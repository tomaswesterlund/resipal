import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';
import 'package:short_navigation/short_navigation.dart';

class PropertyListView extends StatefulWidget {
  final List<PropertyEntity> properties;
  final bool showRegisterProperty;

  const PropertyListView(this.properties, {this.showRegisterProperty = false, super.key});

  @override
  State<PropertyListView> createState() => _PropertyListViewState();
}

class _PropertyListViewState extends State<PropertyListView> {
  late FilterSelectorItem<bool?> _selectedFilter;
  late List<FilterSelectorItem<bool?>> _filterOptions;

  @override
  void initState() {
    super.initState();
    _filterOptions = [
      const FilterSelectorItem(label: 'Todas', value: null),
      const FilterSelectorItem(label: 'Con deuda', value: true),
    ];
    _selectedFilter = _filterOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Filter Logic
    final filteredProperties = _selectedFilter.value == null
        ? widget.properties
        : widget.properties.where((p) => p.hasDebt == _selectedFilter.value).toList();

    // 2. Sort by name
    filteredProperties.sort((a, b) => a.name.compareTo(b.name));

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

            if (filteredProperties.isEmpty)
              _buildEmptyFilterState(context)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProperties.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final property = filteredProperties[index];
                  return PropertyTile(property: property);
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

    // Use Green if "Con deuda" filter is active but empty (Success state)
    final bool isSuccessState = _selectedFilter.value == true;
    final Color stateColor = isSuccessState ? Colors.green.shade600 : colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Icon(
            isSuccessState ? Icons.verified_user_outlined : Icons.search_off_outlined,
            color: stateColor.withOpacity(0.5),
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            isSuccessState ? '¡Excelente! No hay propiedades con deuda.' : 'No hay unidades que coincidan',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.inverseSurface, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
