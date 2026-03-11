import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class ApplicationCard extends StatelessWidget {
  final ApplicationEntity application;

  const ApplicationCard(this.application, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final statusColor = application.status.color(colorScheme);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status Color Sidebar
              Container(width: 6, color: statusColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Header: Applicant Name & Roles ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText.five(application.name, color: colorScheme.onSurface),
                                const SizedBox(height: 2),
                                StatusBadge(color: statusColor, label: application.status.display)
                              ],
                            ),
                          ),
                          _buildRoleIcons(context),
                        ],
                      ),

                      const Divider(height: 24, thickness: 1),

                      // --- Body: Contact Info ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(Icons.email_outlined, application.email, context),
                                const SizedBox(height: 4),
                                _buildInfoRow(
                                  Icons.phone_outlined,
                                  PhoneFormatter.toDisplay(application.phoneNumber),
                                  context,
                                ),
                              ],
                            ),
                          ),

                          ActionLink(
                            label: 'Detalles',
                            onTap: () => Go.to(ApplicationDetailsPage(application: application)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildInfoRow(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleIcons(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.outlineVariant;
    return Row(
      children: [
        if (application.isAdmin) _buildSmallIcon(Icons.admin_panel_settings, iconColor),
        if (application.isSecurity) _buildSmallIcon(Icons.shield_outlined, iconColor),
        if (application.isResident) _buildSmallIcon(Icons.home_work_outlined, iconColor),
      ],
    );
  }

  Widget _buildSmallIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
