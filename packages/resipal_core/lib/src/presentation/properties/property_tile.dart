import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class PropertyTile extends StatelessWidget {
  final PropertyEntity property;

  const PropertyTile({required this.property, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Obtenemos el color basado en el estatus de pago de la propiedad
    final Color statusColor = property.propertyPaymentStatus.color(colorScheme);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Go.to(PropertyDetailsPage(property: property)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            children: [
              // 1. Icono de Propiedad con el color del estatus de pago
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1), 
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.house_outlined, 
                  size: 20, 
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 16),

              // 2. Información de la Propiedad
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Propiedad'),
                    HeaderText.five(
                      property.name, 
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),

              // 3. Información del Residente con manejo de overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Residente'),
                    BodyText.medium(
                      property.resident?.name ?? 'Sin residente',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: property.resident == null 
                          ? colorScheme.error 
                          : colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24.0),
              const Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}