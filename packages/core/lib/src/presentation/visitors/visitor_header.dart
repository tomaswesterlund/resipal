import 'package:flutter/material.dart';
import 'package:ui/lib.dart';
import 'package:core/lib.dart';
import 'package:intl/intl.dart';

class VisitorHeader extends StatelessWidget {
  final VisitorEntity visitor;

  const VisitorHeader({required this.visitor, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    // Formateo para el área central del Header
    final String day = DateFormat('dd').format(visitor.createdAt);
    final String monthYear = DateFormat('MMM, yyyy').format(visitor.createdAt).toUpperCase();
    final String time = DateFormat('HH:mm').format(visitor.createdAt);

    return GradientCard(
      child: Column(
        children: [
          // Sección Superior: Icono y Nombre del Visitante
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_pin_rounded, color: Colors.white, size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: HeaderText.two(visitor.name, color: Colors.white, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          // Información Central: Fecha y Hora de Acceso
          Column(
            children: [
              OverlineText('FECHA DE INGRESO', color: Colors.white.withOpacity(0.8)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    day,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    monthYear,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
              BodyText.medium('A las $time hrs', color: Colors.white.withOpacity(0.8)),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 16),

          // Sección Inferior: ID de Registro y Estatus
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Columna Identificador
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('ID REGISTRO', color: Colors.white),
                    const SizedBox(height: 2),
                    BodyText.small(visitor.id.substring(0, 12).toUpperCase(), color: onPrimary.withOpacity(0.8)),
                  ],
                ),
              ),

              // Columna Estatus (Simulado como 'Verificado')
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('ESTATUS', color: Colors.white),
                  const SizedBox(height: 4),
                  StatusBadge(label: 'VERIFICADO', color: Theme.of(context).colorScheme.onPrimary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
