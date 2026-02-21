import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_admin/presentation/contracts/register_contract/register_contract_page.dart';
import 'package:resipal_admin/shared/buttons/primary_cta_button.dart';
import 'package:resipal_core/domain/entities/contract_entity.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';
import 'package:resipal_core/presentation/shared/texts/amount_text.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:short_navigation/short_navigation.dart';
import 'contract_list_cubit.dart';
import 'contract_list_state.dart';

class ContractListPage extends StatelessWidget {
  const ContractListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContractListCubit()..initialize(),
      child: Scaffold(
        backgroundColor: BaseAppColors.background,
        appBar: const MyAppBar(title: 'Contratos y Cuotas'),
        body: BlocBuilder<ContractListCubit, ContractListState>(
          builder: (context, state) {
            if (state is LoadingState) return const LoadingView();
            if (state is ErrorState) return ErrorView();

            if (state is EmptyState) {
              return _Empty();
            }

            if (state is LoadedState) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.contracts.length,
                itemBuilder: (context, index) => _ContractCard(state.contracts[index]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF1A4644),
          onPressed: () => Go.to(RegisterContractPage()),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class _ContractCard extends StatelessWidget {
  final ContractEntity contract;
  const _ContractCard(this.contract);

  @override
  Widget build(BuildContext context) {
    const Color themeColor = Color(0xFF1A4644);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withOpacity(0.1), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 6, color: themeColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText.five(contract.name, color: themeColor),
                                Text(
                                  contract.period, // Ej: "Mensual" or "Anual"
                                  style: GoogleFonts.raleway(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: BaseAppColors.auxiliarScale[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.assignment_outlined, color: themeColor, size: 20),
                        ],
                      ),
                      const Divider(height: 24, thickness: 1, color: Color(0xFFF4F5F4)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Monto de la cuota',
                                style: GoogleFonts.raleway(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: BaseAppColors.auxiliarScale[400],
                                ),
                              ),
                              AmountText.fromCents(
                                contract.amountInCents,
                                fontSize: 18,
                                color: BaseAppColors.secondary,
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: themeColor,
                              textStyle: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            onPressed: () {
                              // Details logic
                            },
                            child: const Row(
                              children: [
                                Text('Gestionar'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios, size: 12),
                              ],
                            ),
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
}

class _Empty extends StatelessWidget {
  const _Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Visual indicator (Empty clipboard/document icon)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: const Color(0xFF1A4644).withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.assignment_add, size: 64, color: Color(0xFF1A4644)),
          ),
          const SizedBox(height: 32),

          HeaderText.four('Sin contratos configurados', textAlign: TextAlign.center, color: const Color(0xFF1A4644)),
          const SizedBox(height: 16),

          Text(
            'Los contratos definen los montos y periodos de cobro para tus residentes (ej: Cuota de Mantenimiento). Necesitas crear al menos uno para empezar a registrar propiedades.',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(fontSize: 15, color: Colors.grey.shade600, height: 1.5),
          ),
          const SizedBox(height: 48),

          PrimaryCtaButton(label: 'Configurar mi primer contrato', onPressed: () => Go.to(RegisterContractPage())),
        ],
      ),
    );
  }
}
