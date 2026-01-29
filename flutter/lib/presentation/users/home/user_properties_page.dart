import 'package:flutter/material.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/presentation/properties/property_card.dart';
import 'package:resipal/presentation/properties/property_details_page.dart';
import 'package:short_navigation/short_navigation.dart';

class UserPropertiesPage extends StatelessWidget {
  final UserEntity user;
  const UserPropertiesPage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          GreenBoxContainer(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: HeaderText.two('Mis Propiedades', color: Colors.white),
                ),
              ),
            ),
          ),

          // Property List
          Expanded(
            child: user.properties.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: user.properties.length,
                    itemBuilder: (context, index) {
                      final property = user.properties[index];
                      return PropertyCard(property);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home_work_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No tienes propiedades registradas',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
