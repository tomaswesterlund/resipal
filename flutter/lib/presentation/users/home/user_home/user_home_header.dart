import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/user_entity.dart';

class UserHomeHeader extends StatelessWidget {
  final UserEntity user;
  const UserHomeHeader(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: [
            // 1. Profile Image with Border
            Container(
              padding: const EdgeInsets.all(3), // Border thickness
              decoration: const BoxDecoration(
                color: Color(0xFF8BAE96), // The sage green border color
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                  'https://your-image-url.com/jorge.jpg',
                ),
              ),
            ),
            const SizedBox(width: 16),
      
            // 2. Greeting Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      HeaderText.four('¡Hola!', fontWeight: FontWeight.normal),
                      SizedBox(width: 4),
                      Text('👋', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                  HeaderText.four(user.name),
                ],
              ),
            ),
      
            // 3. Notification Bell with Badge
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_none_outlined,
                    color: Color(0xFF1E1E1E),
                    size: 28,
                  ),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
