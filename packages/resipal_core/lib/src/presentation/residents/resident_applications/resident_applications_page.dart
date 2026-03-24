import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/residents/resident_applications/resident_application_cubit.dart';
import 'package:resipal_core/src/presentation/residents/resident_applications/resident_application_state.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';
import 'package:intl/intl.dart';

class ResidentApplicationsPage extends StatelessWidget {
  final UserEntity user;
  const ResidentApplicationsPage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => ResidentApplicationCubit()..initialize(user),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: const MyAppBar(title: 'Mis Solicitudes'),
        body: Column(
          children: [
            // --- Header Estático (Siempre visible) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText.five('Gestión de Solicitudes', color: colorScheme.primary),
                  const SizedBox(height: 8),
                  BodyText.medium(
                    'Aquí puedes consultar el estado de tus peticiones para unirte a una comunidad. Una vez aprobada, podrás acceder a todas las funciones de residente.',
                  ),
                ],
              ),
            ),

            // --- Contenido Dinámico (Estado del Bloc) ---
            Expanded(
              child: BlocBuilder<ResidentApplicationCubit, ResidentApplicationState>(
                builder: (context, state) {
                  if (state is ResidentApplicationLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ResidentApplicationErrorState) {
                    return const ErrorView();
                  }

                  if (state is ResidentApplicationJoinedSuccessfullyState) {
                    return SuccessView(
                      title: '¡Bienvenido a casa!',
                      subtitle: 'Tu solicitud ha sido aceptado correctamente. ',
                      actionButtonLabel: 'Ir al Inicio',
                      onActionButtonPressed: () {
                        Go.to(ResidentHomePage(community: state.community, resident: state.resident));
                      },
                    );
                  }

                  if (state is ResidentApplicationLoadedState) {
                    final apps = state.applications;

                    if (apps.isEmpty) return const _EmptyApplications();

                    return ListView.separated(
                      padding: const EdgeInsets.all(24.0),
                      itemCount: apps.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) => _ApplicationTile(application: apps[index]),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),

            // --- Footer de Soporte ---
            const _SupportFooter(),
          ],
        ),
      ),
    );
  }
}

class _ApplicationTile extends StatelessWidget {
  final ApplicationEntity application;
  const _ApplicationTile({required this.application});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final Color statusColor = application.status.color(colorScheme);
    final dateStr = DateFormat('dd/MM/yyyy').format(application.createdAt);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        // Si está aprobado, podrías navegar directamente al dashboard de esa comunidad
        onTap: application.status == ApplicationStatus.approved ? () {} : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 1. Icono de Estatus (Cambiado a check si está aprobado)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(
                      application.status == ApplicationStatus.approved
                          ? Icons.check_circle_outline_rounded
                          : Icons.assignment_outlined,
                      size: 22,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 2. Columna: Comunidad (En lugar de "Aplicante")
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const OverlineText('Comunidad'),
                        const SizedBox(height: 4),
                        HeaderText.five(
                          application.community.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 3. Columna: Fecha de Solicitud
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const OverlineText('Fecha'),
                        const SizedBox(height: 4),
                        BodyText.small(dateStr, fontWeight: FontWeight.w600, color: colorScheme.onSurfaceVariant),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Chevron condicional (solo si puede interactuar)
                  if (application.status == ApplicationStatus.approved)
                    const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black38),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OverlineText('Mensaje'),
                      const SizedBox(height: 4),
                      BodyText.tiny(
                        application.message,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  Spacer(),
                  CheckmarkButton(
                    size: 40,
                    onPressed: () => context.read<ResidentApplicationCubit>().acceptApplication(application),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportFooter extends StatelessWidget {
  const _SupportFooter();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          BodyText.medium('¿Crees que hay un error?'),
          BodyText.small('Comunícate con Resipal por WhatsApp'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: WhatsAppIconButton(
              onPressed: () {
                // Lógica para abrir WhatsApp (ej: launchUrl)
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _EmptyApplications extends StatelessWidget {
  const _EmptyApplications();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono con contenedor circular tonal (Estilo Wester Kit)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.08), shape: BoxShape.circle),
              child: Icon(Icons.assignment_outlined, size: 64, color: colorScheme.primary.withOpacity(0.5)),
            ),
            const SizedBox(height: 32),

            // Título de estado vacío
            HeaderText.four('Sin solicitudes activas', textAlign: TextAlign.center),
            const SizedBox(height: 12),

            // Texto descriptivo
            BodyText.medium(
              'Parece que aún no has recibido ninguna solicitud para unirte a una comunidad.',
              textAlign: TextAlign.center,
              color: colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckmarkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double size;

  const CheckmarkButton({super.key, required this.onPressed, this.isEnabled = true, this.size = 48.0});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Color verde semántico de éxito (puedes usar colorScheme.tertiary si lo tienes configurado)
    final Color activeColor = Colors.green.shade600;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isEnabled ? activeColor : colorScheme.surfaceVariant.withOpacity(0.5),
        boxShadow: isEnabled
            ? [BoxShadow(color: activeColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Center(
            child: Icon(
              Icons.check_circle_outline_rounded,
              color: isEnabled ? Colors.white : colorScheme.outline.withOpacity(0.5),
              size: size * 0.55,
            ),
          ),
        ),
      ),
    );
  }
}
