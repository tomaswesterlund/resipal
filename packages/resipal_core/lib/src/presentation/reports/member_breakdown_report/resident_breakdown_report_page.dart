import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ResidentBreakdownReportPage extends StatelessWidget {
  const ResidentBreakdownReportPage({super.key});

  Future<void> _generatePdf(ResidentBreakdownReportLoadedState state) async {
    final pdf = pw.Document();
    final formatCurrency = NumberFormat.simpleCurrency();

    // Load logo from assets
    final logoData = await rootBundle.load('packages/resipal_core/assets/resipal_logo_green.png');
    final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());

    // 1. Pre-procesar los datos y asignar colores por bloque de miembro
    final List<List<dynamic>> tableData = [];
    final List<pw.BoxDecoration> rowDecorations = [];

    for (var i = 0; i < state.residents.length; i++) {
      final m = state.residents[i];
      final properties = m.propertyRegistry.properties;

      // Alternar color: Blanco para pares, Gris tenue para impares
      final rowColor = i % 2 == 0 ? PdfColors.white : PdfColors.grey100;
      final decoration = pw.BoxDecoration(
        color: rowColor,
        border: const pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: .5)),
      );

      // Fila principal
      tableData.add([
        m.name,
        properties.length == 1 ? properties.first.name : '',
        formatCurrency.format(m.paymentLedger.totalPaymentBalanceInCents / 100),
        formatCurrency.format(m.paymentLedger.pendingPaymentAmountInCents / 100),
        properties.length == 1 ? formatCurrency.format(m.propertyRegistry.totalDebtAmountInCents / 100) : '',
      ]);
      rowDecorations.add(decoration);

      // Sub-filas (si tiene múltiples propiedades)
      if (properties.length > 1) {
        for (var p in properties) {
          tableData.add(['', p.name, '', '', CurrencyFormatter.fromCents(p.totalDebtAmountInCents)]);
          rowDecorations.add(decoration);
        }
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          // --- HEADER ---
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(
                children: [
                  pw.Image(logoImage, width: 50),
                  pw.SizedBox(width: 8.0),
                  pw.Text('RESIPAL', style: pw.TextStyle(fontSize: 36, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text('Desglose de miembros', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                    'Comunidad: ${state.community.name}',
                    style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                  ),
                  pw.Text(
                    'Generado el: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
                    style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                  ),
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 25),

          // --- DASHBOARD SUMMARY ---
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildStatBox('Miembros', '${state.residents.length}'),
              pw.SizedBox(width: 4),
              _buildStatBox('Propiedades', '${state.residents.fold(0, (sum, m) => sum + m.propertyRegistry.count)}'),
              pw.SizedBox(width: 4),
              _buildStatBox('Saldo total', '${CurrencyFormatter.fromCents(state.community.totalBalanceInCents)}'),
              pw.SizedBox(width: 4),
              _buildStatBox(
                'Pagos por Revisar',
                formatCurrency.format(state.totalPendingCents / 100),
                valueColor: PdfColors.orange,
              ),
              pw.SizedBox(width: 4),
              _buildStatBox(
                'Deuda Total',
                formatCurrency.format(state.totalDebtCents / 100),
                valueColor: PdfColors.red,
              ),
            ],
          ),

          pw.SizedBox(height: 20),

          // --- DATA TABLE ---
          pw.TableHelper.fromTextArray(
            border: null,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey800),
            cellHeight: 25,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
              4: pw.Alignment.centerRight,
            },
            headers: ['Nombre', 'Propiedad', 'Saldo', 'Pendiente', 'Deuda'],
            data: tableData,
            cellDecoration: (index, data, rowNum) {
              // rowNum es 1-based y el 0 es el header, por lo que restamos 1 para nuestro array
              return rowDecorations[rowNum - 1];
            },
          ),
        ],
      ),
    );

    // --- SAVE & OPEN ---
    final pdfService = GetIt.I<PdfService>();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = '${timestamp}_reporte_desglose_miembros.pdf';

    final file = await pdfService.save(name: fileName, pdf: pdf);
    await pdfService.open(file);
  }

  /// Helper for the Summary Boxes
  pw.Widget _buildStatBox(String title, String value, {PdfColor? valueColor}) {
    return pw.Container(
      width: 110,
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
        border: pw.Border.all(color: PdfColors.grey200),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title.toUpperCase(), style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey600)),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: valueColor ?? PdfColors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ResidentBreakdownReportCubit()..initialize(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: MyAppBar(
          title: 'Desglose de Miembros',
          actions: [
            // Use BlocBuilder here to access the current state data for the PDF
            BlocBuilder<ResidentBreakdownReportCubit, ResidentBreakdownReportState>(
              builder: (context, state) {
                if (state is ResidentBreakdownReportLoadedState) {
                  return IconButton(
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    onPressed: () => _generatePdf(state),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<ResidentBreakdownReportCubit, ResidentBreakdownReportState>(
          builder: (ctx, state) {
            if (state is ResidentBreakdownReportLoadingState) return const LoadingView();
            if (state is ResidentBreakdownReportErrorState) return const ErrorView();

            if (state is ResidentBreakdownReportLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _SummaryHeader(state),
                    ),
                    state.residents.isEmpty ? const _EmptyReport() : _ReportList(residents: state.residents),
                    const SizedBox(height: 48.0),
                  ],
                ),
              );
            }
            return const UnknownStateView();
          },
        ),
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  final ResidentBreakdownReportLoadedState state;

  const _SummaryHeader(this.state);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pendingAmount = state.community.paymentLedger.pendingPaymentAmountInCents;
    final totalDebt = state.community.propertyRegistry.totalDebtAmountInCents;

    return GradientCard(
      child: Column(
        children: [
          OverlineText('SALDO TOTAL EN COMUNIDAD', color: colorScheme.onPrimary.withOpacity(0.7)),
          const SizedBox(height: 8),
          AmountText(
            amountInCents: state.totalBalanceCents,
            fontSize: 42,
            color: colorScheme.onPrimary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          Divider(color: colorScheme.onPrimary.withOpacity(0.2), height: 1),
          const SizedBox(height: 24),

          // Secondary Financial Metrics
          Row(
            children: [
              Expanded(
                child: _HeaderMiniStat(
                  label: 'POR REVISAR',
                  value: CurrencyFormatter.fromCents(pendingAmount),
                  icon: Icons.hourglass_empty_rounded,
                  accentColor: Colors.orangeAccent,
                ),
              ),
              Container(width: 1, height: 40, color: colorScheme.onPrimary.withOpacity(0.1)),
              Expanded(
                child: _HeaderMiniStat(
                  label: 'DEUDA TOTAL',
                  value: CurrencyFormatter.fromCents(totalDebt),
                  icon: Icons.trending_down_rounded,
                  accentColor: Colors.redAccent,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _HeaderMiniStat(
                  label: 'MIEMBROS',
                  value: state.residents.length.toString(),
                  icon: Icons.people,
                  accentColor: Colors.white,
                ),
              ),
              Container(width: 1, height: 40, color: colorScheme.onPrimary.withOpacity(0.1)),
              Expanded(
                child: _HeaderMiniStat(
                  label: 'PROPIEDADES',
                  value: state.community.propertyRegistry.count.toString(),
                  icon: Icons.house,
                  accentColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderMiniStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accentColor;

  const _HeaderMiniStat({required this.label, required this.value, required this.icon, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: accentColor),
            const SizedBox(width: 6),
            OverlineText(label, color: colorScheme.onPrimary.withOpacity(0.6)),
          ],
        ),
        const SizedBox(height: 4),
        HeaderText.two(value, color: Colors.white)
      ],
    );
  }
}

class _ResidentReportTile extends StatelessWidget {
  final ResidentMemberEntity resident;
  const _ResidentReportTile(this.resident);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final properties = resident.propertyRegistry.properties.map((p) => p.name).join(', ');
    final pendingAmount = resident.paymentLedger.pendingPaymentAmountInCents;

    return DefaultCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText.five(resident.name),
                      const SizedBox(height: 2),
                      BodyText.small(properties.isEmpty ? 'Sin propiedades' : properties, color: colorScheme.outline),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AmountColumn(
                  label: 'SALDO TOTAL',
                  cents: resident.paymentLedger.totalPaymentBalanceInCents,
                  color: colorScheme.tertiary,
                ),
                _AmountColumn(
                  label: 'PENDIENTE',
                  cents: pendingAmount,
                  color: pendingAmount > 0 ? Colors.orange.shade700 : colorScheme.onSurfaceVariant,
                ),
                _AmountColumn(
                  label: 'DEUDA VENCIDA',
                  cents: resident.propertyRegistry.totalDebtAmountInCents,
                  color: resident.propertyRegistry.hasDebt ? colorScheme.error : colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportList extends StatelessWidget {
  final List<ResidentMemberEntity> residents;
  const _ReportList({required this.residents});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: residents.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (ctx, index) => _ResidentReportTile(residents[index]),
    );
  }
}

class _HeaderItem extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? customValue;

  const _HeaderItem({required this.label, this.value, this.customValue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800, color: theme.colorScheme.outline),
        ),
        const SizedBox(height: 4),
        customValue ?? HeaderText.five(value!),
      ],
    );
  }
}

class _AmountColumn extends StatelessWidget {
  final String label;
  final int cents;
  final Color color;

  const _AmountColumn({required this.label, required this.cents, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
        AmountText(amountInCents: cents, fontSize: 14, color: color),
      ],
    );
  }
}

class _EmptyReport extends StatelessWidget {
  const _EmptyReport();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BodyText.medium(
        'No se encontraron registros para este reporte.',
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }
}
