import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:core/src/presentation/visitors/visitor_details/visitor_details_page.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/lib.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class VisitorTile extends StatelessWidget {
  final VisitorEntity visitor;

  const VisitorTile({required this.visitor, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Formateo de fecha para mostrar en el subtitulo
    final String formattedDate = DateFormat('dd MMM, yyyy').format(visitor.createdAt);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        // Suponiendo que existiría una página de detalles del visitante
        onTap: () => Go.to(VisitorDetailsPage(visitor: visitor)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            children: [
              // 1. Icono de Visitante
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.person_pin_outlined, size: 20, color: colorScheme.primary),
              ),
              const SizedBox(width: 16),

              // 2. Información del Visitante (Nombre Principal)
              Expanded(
                flex: 2, // Le damos un poco más de peso al nombre
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Visitante'),
                    HeaderText.five(
                      visitor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),

              // 3. Información de Registro/Fecha
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Registro'),
                    BodyText.medium(
                      formattedDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12.0),
              const Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
