import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/presentation/shared/cards/default_card.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/containers/green_box_container.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class UserProfileView extends StatelessWidget {
  final UserEntity user;

  const UserProfileView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseAppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                GreenBoxContainer(
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 24.0, bottom: 60.0),
                      child: const HeaderText.one(
                        'Mi Perfil',
                        color: Colors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                // Floating Avatar Logic
                Positioned(
                  bottom: -60,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/300?u=${user.id}',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Edit Button Overlay
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.camera_alt, size: 14, color: BaseAppColors.secondary),
                            SizedBox(width: 4),
                            Text(
                              'EDITAR',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: BaseAppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Spacer for the floating avatar height
            const SizedBox(height: 80),

            // --- User Name ---
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: BaseAppColors.secondary,
              ),
            ),
            const SizedBox(height: 32),

            // --- Menu Options inside DefaultCard ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DefaultCard(
                padding: 0,
                child: Column(
                  children: [
                    _buildMenuTile(
                      title: 'Datos Personales',
                      subtitle: 'Mi perfil',
                      onTap: () {},
                    ),
                    // const Divider(height: 1, indent: 16, endIndent: 16),
                    // _buildMenuTile(
                    //   title: 'Mis Propiedades',
                    //   subtitle: user.properties.isNotEmpty 
                    //       ? user.properties.map((p) => p.name).join(' / ') 
                    //       : 'Sin propiedades',
                    //   onTap: () {},
                    // ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildMenuTile(
                      title: 'Seguridad y Accesos',
                      subtitle: 'Gestión de seguridad',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildMenuTile(
                      title: 'Configuración',
                      subtitle: 'Controla tus preferencias',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Logout Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseAppColors.danger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'CERRAR SESIÓN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 148), // Added extra space for the Floating Nav Bar
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: BaseAppColors.secondary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 13,
          color: BaseAppColors.hintText,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black, size: 20),
    );
  }
}