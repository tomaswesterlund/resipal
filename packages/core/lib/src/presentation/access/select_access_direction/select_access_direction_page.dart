import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/lib.dart';

class SelectAccessDirectionPage extends StatelessWidget {
  final InvitationEntity invitation;

  const SelectAccessDirectionPage({required this.invitation, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Registrar Movimiento', backgroundColor: Colors.transparent),
      body: BlocProvider<SelectAccessDirectionCubit>(
        create: (context) => SelectAccessDirectionCubit(),
        child: BlocConsumer<SelectAccessDirectionCubit, SelectAccessDirectionState>(
          listener: (context, state) {
            if (state is SelectAccessDirectionLoggedSuccessfullyState) {
              Go.to(AccessGrantedPage(title: state.invitation.visitor.name, reason: 'Registrada'));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText.large('Selecciona el tipo de acceso', fontWeight: FontWeight.bold),
                  const SizedBox(height: 8),
                  BodyText.medium('Invitado: ${invitation.visitor.name}', color: Colors.grey),
                  const SizedBox(height: 32),

                  // 1. Entry Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.read<SelectAccessDirectionCubit>().onEntrySelected(invitation),
                      child: DefaultCard(
                        // color: Colors.green.shade50,
                        // borderColor: Colors.green.shade200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login_rounded, size: 64, color: Colors.green),
                              const SizedBox(height: 16),
                              BodyText.large('REGISTRAR ENTRADA', fontWeight: FontWeight.bold, color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 2. Exit Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.read<SelectAccessDirectionCubit>().onExitSelected(invitation),
                      child: DefaultCard(
                        // color: Colors.blue.shade50,
                        // borderColor: Colors.blue.shade200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_rounded, size: 64, color: Colors.blue.shade700),
                              const SizedBox(height: 16),
                              BodyText.large('REGISTRAR SALIDA', fontWeight: FontWeight.bold, color: Colors.blue),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
