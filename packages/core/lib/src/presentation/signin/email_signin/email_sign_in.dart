import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/src/presentation/signin/email_signin/email_sign_in_cubit.dart';
import 'package:core/src/presentation/signin/email_signin/email_sign_in_formstate.dart';
import 'package:core/src/presentation/signin/email_signin/email_sign_in_state.dart';
import 'package:ui/lib.dart';

class EmailSignIn extends StatelessWidget {
  final VoidCallback? onSuccess;

  const EmailSignIn({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailSignInCubit()..initialize(),
      child: BlocConsumer<EmailSignInCubit, EmailSignInState>(
        listener: (context, state) {
          if (state is EmailSignInSuccessState) {
            onSuccess?.call();
          }
        },
        builder: (context, state) {
          if (state is EmailSignInSubmittingState) {
            return const LoadingView(title: 'Iniciando sesión...');
          }

          if (state is EmailSignInErrorState) {
            return const ErrorView();
          }

          if (state is EmailSignInFormEditingState || state is EmailSignInInvalidCredentialsState) {
            final formState = state is EmailSignInFormEditingState
                ? state.formState
                : EmailSignInFormState.initial();
            return _Form(
              formState: formState,
              showInvalidCredentials: state is EmailSignInInvalidCredentialsState,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final EmailSignInFormState formState;
  final bool showInvalidCredentials;

  const _Form({required this.formState, this.showInvalidCredentials = false});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmailSignInCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextInputField(
          label: 'Correo electrónico',
          hint: 'correo@ejemplo.com',
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
          errorText: formState.email.errorMessage,
          onChanged: cubit.updateEmail,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 12),
        TextInputField(
          label: 'Contraseña',
          hint: '••••••••',
          isRequired: true,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outlined),
          errorText: formState.password.errorMessage,
          onChanged: cubit.updatePassword,
        ),
        if (showInvalidCredentials) ...[
          const SizedBox(height: 8),
          Text(
            'Correo o contraseña incorrectos.',
            style: TextStyle(color: colorScheme.error, fontSize: 13),
          ),
        ],
        const SizedBox(height: 16),
        PrimaryButton(label: 'Iniciar sesión', onPressed: cubit.submit),
      ],
    );
  }
}
