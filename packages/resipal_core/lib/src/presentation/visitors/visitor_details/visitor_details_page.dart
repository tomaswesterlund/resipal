import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/visitors/visitor_header.dart';
import 'package:wester_kit/lib.dart';
import 'package:intl/intl.dart';

class VisitorDetailsPage extends StatefulWidget {
  final VisitorEntity visitor;
  const VisitorDetailsPage({required this.visitor, super.key});

  @override
  State<VisitorDetailsPage> createState() => _VisitorDetailsPageState();
}

class _VisitorDetailsPageState extends State<VisitorDetailsPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const MyAppBar(title: 'Detalle de Visitante'),
      body: _currentPageIndex == 0 ? _VisitorOverview(widget.visitor) : _VisitorIdentification(widget.visitor),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: FloatingNavBar(
          currentIndex: _currentPageIndex,
          onChanged: (index) => setState(() => _currentPageIndex = index),
          items: [
            FloatingNavBarItem(icon: Icons.info_outline_rounded, label: 'General'),
            FloatingNavBarItem(icon: Icons.badge_outlined, label: 'Identificación'),
          ],
        ),
      ),
    );
  }
}

// --- VIEW 1: GENERAL INFORMATION ---
class _VisitorOverview extends StatelessWidget {
  final VisitorEntity visitor;
  const _VisitorOverview(this.visitor);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final String formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(visitor.createdAt);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisitorHeader(visitor: visitor),
          const SizedBox(height: 32),
          const SectionHeaderText(text: 'DETALLES DEL REGISTRO'),
          DefaultCard(
            child: Column(
              children: [
                DetailTile(icon: Icons.calendar_today_rounded, label: 'Fecha de Ingreso', value: formattedDate),
                Divider(height: 1, color: colorScheme.outlineVariant),
                DetailTile(
                  icon: Icons.fingerprint_rounded,
                  label: 'ID de Sistema',
                  value: visitor.id.substring(0, 8).toUpperCase(),
                ),
                Divider(height: 1, color: colorScheme.outlineVariant),
                DetailTile(
                  icon: Icons.account_circle_outlined,
                  label: 'Registrado por (User ID)',
                  value: visitor.userId.substring(0, 8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

// --- VIEW 2: IDENTIFICATION VIEW ---
class _VisitorIdentification extends StatelessWidget {
  final VisitorEntity visitor;
  const _VisitorIdentification(this.visitor);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderText(text: 'DOCUMENTO DE IDENTIDAD'),
          const SizedBox(height: 12),
          DefaultCard(
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Aquí podrías usar un CachedNetworkImage cuando tengas el link de Supabase
                Icon(Icons.image_not_supported_outlined, size: 64, color: colorScheme.outline),
                const SizedBox(height: 16),
                BodyText.medium('Ruta del archivo:', color: colorScheme.onSurfaceVariant),
                const SizedBox(height: 4),
                BodyText.small(visitor.identificationPath, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                Divider(height: 1, color: colorScheme.outlineVariant),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    label: 'Ver Documento Completo',
                    onPressed: () {
                      // Lógica para abrir visor de fotos
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
